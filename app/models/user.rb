class User < ApplicationRecord
  has_and_belongs_to_many :time_blocks
  has_many :day_blocks, foreign_key: :coach_id, class_name: "DayBlock"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
