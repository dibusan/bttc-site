class Reservation < ApplicationRecord
  belongs_to :user

  def self.week_schedule(
      type_lesson: false,
      max_availability: Rails.application.config.club_max_availability,
      coach_id: nil,
      user: nil,
      start_date:
  )
    end_date = start_date + 7.days

    reservations = if coach_id
                     Reservation
                       .where(coach_id: coach_id)
                       .where('scheduled_for >= ?', start_date.beginning_of_day)
                       .where('scheduled_for < ?', end_date.end_of_day)
                       .where(type_play?: !type_lesson)
                   else
                     Reservation
                       .where('scheduled_for >= ?', start_date.beginning_of_day)
                       .where('scheduled_for < ?', end_date.end_of_day)
                       .where(type_play?: !type_lesson)
                   end

    schedule = Hash.new
    reservations.map do |reserv|
      key_date = reserv.scheduled_for.to_i

      schedule[key_date] ||= Hash.new
      schedule[key_date][:count] ||= max_availability
      schedule[key_date][:reservations] ||= []

      schedule[key_date][:reservations] << reserv
      schedule[key_date][:count] -= reserv.party_size
      schedule[key_date][:current_user] = (reserv.user == user)
    end

    schedule
  end

  def self.today(coach_id: nil)
    today = DateTime.now

    reservations =
      if coach_id
        Reservation
          .where(coach_id: coach_id)
          .where(type_lesson?: true)
          .where('scheduled_for >= ?', today.beginning_of_day)
          .where('scheduled_for < ?', today.end_of_day)
          .order(scheduled_for: :asc)
      else
        Reservation
          .where('scheduled_for >= ?', today.beginning_of_day)
          .where('scheduled_for < ?', today.end_of_day)
          .where(type_play?: true)
          .order(scheduled_for: :asc)
      end

    reservations
  end

  def self.count_for_block(start_date, end_date)
    Reservation
      .where('scheduled_for >= ?', start_date.beginning_of_day)
      .where('scheduled_for < ?', end_date.end_of_day)
      .count()
  end

end
