class ReservationsController < ApplicationController
  helper_method :color_by_availability, :fulltime

  # enum availability_group: [:empty, :few, :many]
  def index
    @day_blocks = DayBlock.all.limit(10)
  end

  def new

  end

  def reserve
    # today = DateTime.now.beginning_of_day
    # 10.times do
    #   dayblock = DayBlock.create!(schedule_date: today)
    #   timeblock = dayblock.schedule_date + 8.hours
    #
    #   48.times do
    #     dayblock.time_blocks.create!(
    #       block_start_time: timeblock,
    #       availability: 24
    #     )
    #
    #     timeblock += 15.minutes
    #   end
    #
    #   today += 1.day
    # end
  end


  def fulltime(created_at)
    created_at.to_s(:date)+" "+created_at.to_s(:time).gsub(/^0/,'').downcase
  end

  def color_by_availability(total_available)
    # total_available = rand(total_available)
    if total_available <= 0
      # "C82538"
      "empty"
    elsif total_available < 5
      # "675E24"
      "few"
    else
      # "2E7F18"
      "many"
    end
  end
end
