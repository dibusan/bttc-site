class User < ApplicationRecord
  has_and_belongs_to_many :time_blocks
  has_many :day_blocks, foreign_key: :coach_id, class_name: "DayBlock"
  has_many :reservations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum membership_type: [:monthly, :quarterly, :yearly]

  def week_reservations(start_date)
    end_date = start_date + 7.days
    reservations = self.reservations
                      .where('scheduled_for >= ?', start_date.beginning_of_day)
                      .where('scheduled_for < ?', end_date.end_of_day)
                      .where(type_play?: true)
                      .map{ |r| [r.scheduled_for, r] }.to_h
    count = Hash.new
    reservations.map do |date, reserv|
      count[reserv.scheduled_for] ||= 0
      count[reserv.scheduled_for] = reserv.party_size
    end
  end

  def cart_count
    $redis.scard "cart#{id}"
  end
end
