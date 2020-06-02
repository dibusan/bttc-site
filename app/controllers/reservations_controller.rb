class ReservationsController < ApplicationController
  helper_method :class_for, :compress_users

  def table
    @start_date =
      if params[:start_date].nil?
        DateTime.now.beginning_of_day
      else
        DateTime.parse(params[:start_date])
      end

    @week_schedule =
      Reservation.week_schedule(
        start_date: @start_date,
        user: current_user
      )

    if current_user.admin_role or current_user.coach_role
      reservations_today = Reservation.today
      @calendar_today = Hash.new
      reservations_today.each do |res|
        @calendar_today[res.scheduled_for.to_i] ||= []
        @calendar_today[res.scheduled_for.to_i] << res
      end
    end
  end

  def lesson
    @start_date =
      if params[:start_date].nil?
        DateTime.now.beginning_of_day
      else
        DateTime.parse(params[:start_date])
      end

    @coach = User.find(params[:coach_id])

    @week_schedule =
      Reservation.week_schedule(
        start_date: @start_date,
        type_lesson: true,
        max_availability: 1,
        coach_id: @coach.id,
        user: current_user
      )
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    @date_time = DateTime.parse(params[:date_time])
    max_availability = Rails.application.config.club_max_availability
    count = Reservation.count_for_block(@date_time, @date_time + 2.hours)
    @available_spots = max_availability - count
    if max_availability - count <= 0
      flash[:error] = "This block is full."
      redirect_to :back
    end
  end

  def create
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    is_lesson = params[:type_lesson] == "true"
    coach_id = params[:coach_id]

    date_time = params[:date_time]
    club_table = params[:club_table]
    party_size = params[:party_size] || 0

    current_user.reservations.create(
      coach_id: coach_id,
      scheduled_for: date_time,
      club_table: club_table,
      party_size: party_size,
      type_lesson?: is_lesson,
      type_play?: !is_lesson
    )

    redirect_to reservations_path
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
    @tab = params[:tab] || 'reservations'
    @day_block = DayBlock.find(params[:day_id])
    @time_blocks = @day_block.time_blocks
  end

  def index
    @reservations = current_user.reservations.order(scheduled_for: :asc)
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

  def class_for(count, type_lesson=false, belongs_to_current_user)
    if belongs_to_current_user
      return "users-reserved"
    end

    if count <= 0
      # "C82538"
      "empty"
    elsif type_lesson or count >= 5
      # "2E7F18"
      "many"
    else
      # "675E24"
      "few"
    end
  end

end
