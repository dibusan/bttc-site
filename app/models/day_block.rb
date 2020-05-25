class DayBlock < ApplicationRecord
  include ActionView::Helpers

  has_many :time_blocks

  def self.create_and_populate(date)
    date = date.to_date.beginning_of_day
    d_block = DayBlock.create!(schedule_date: date)

    day_name = date.strftime('%A')

    club_hours = Rails.application.config.club_hours[day_name.downcase.to_sym]

    tmp_time = club_hours[:start]
    while tmp_time < club_hours[:end]
      d_block.time_blocks.create!(
        block_start_time: tmp_time,
        availability: Rails.application.config.club_max_availability
      )
      tmp_time += Rails.application.config.club_table_reserve_duration
    end
    d_block
  end

  def reset_day
  end
end
