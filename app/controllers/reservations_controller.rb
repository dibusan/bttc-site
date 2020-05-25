class ReservationsController < ApplicationController
  helper_method :color_by_availability, :fulltime, :compress_users

  # enum availability_group: [:empty, :few, :many]
  def index
    @day_blocks = DayBlock.all.limit(10)
  end

  def new

  end

  def create
    @timeblock = TimeBlock.find(params[:time_block_id])
    total_reservations = params[:total_reservations].to_i

    @timeblock.availability -= total_reservations
    total_reservations.times do
      @timeblock.users.push(current_user)
    end

    if @timeblock.save!
      ReservationMailer.new_reservation_email(
        current_user, @timeblock, total_reservations
      ).deliver_now

      flash[:success] = "Reservation Created!"
    else
      flash.now[:error] = "Failed to make reservation."
    end

    redirect_to root_path
  end

  def dashboard
    @day_block = DayBlock.find(params[:day_id])
    @time_blocks = @day_block.time_blocks
  end

  # --- Helpers ---
  protected

  def compress_users(users)
    hash = Hash.new(0)
    users.each do |user|
      hash[user] += 1
    end
    hash
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
