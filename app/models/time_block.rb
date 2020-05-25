class TimeBlock < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :day_block
end
