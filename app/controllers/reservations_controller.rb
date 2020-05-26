class ReservationsController < ApplicationController
  helper_method :color_by_availability, :fulltime, :compress_users

  # enum availability_group: [:empty, :few, :many]
  def calendar
    start_date = params[:start_date] || DateTime.now.beginning_of_day
    start_date = start_date.to_date if start_date .instance_of? String

    day_count = DayBlock.where('schedule_date >= ?', start_date).count

    missing = 7 - day_count
    need_date = DayBlock.last.nil? ? start_date : DayBlock.last.schedule_date + 1.day
    while missing > 0
      DayBlock.create_and_populate need_date
      need_date += 1.day
      missing -= 1
    end
    @day_blocks = DayBlock.where('schedule_date >= ?', start_date).limit(7)
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    @timeblock = TimeBlock.find(params[:time_block_id])

    @total_reservation_options = [*1..[4, @timeblock.availability].min]

    if @timeblock.availability <= 0
      flash[:error] = "This block is full."
      redirect_to :back
    end
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

  def delete
    @timeblock = TimeBlock.find(params[:time_block_id])
    @user = User.find(params[:user_id])

    @timeblock.availability += compress_users(@timeblock.users)[@user]
    @timeblock.users.delete(@user)
    @timeblock.save
    redirect_to :back
  end

  def dashboard
    @day_block = DayBlock.find(params[:day_id])
    @time_blocks = @day_block.time_blocks
  end

  def index
    @timeblocks = current_user
                    .time_blocks
                    .order(block_start_time: :asc)
                    .uniq
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

  def color_by_availability(time_block)
    if time_block.users.include? current_user
      return "users-reserved"
    end

    total_available = time_block.availability
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
