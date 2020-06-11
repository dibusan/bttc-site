class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_dayblock_id, :club_hours_on, :club_reservation_time, :current_user_cart

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_dayblock_id
    DayBlock.find_by(schedule_date: DateTime.now.beginning_of_day).id
  end

  def club_hours_on(day_name)
    hours_hash = Rails.application.config.club_hours
    hours_hash[day_name.downcase]
  end

  def club_reservation_time
    Rails.application.config.club_table_reserve_duration
  end

  def current_user_cart
    "cart#{current_user.id}"
  end

end
