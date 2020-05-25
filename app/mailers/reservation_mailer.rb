class ReservationMailer < ApplicationMailer
  def new_reservation_email(user, time_block, total_reservations)
    @time_block = time_block
    @total_guests = total_reservations
    @user = user
    # Rails.logger.warn "Sending email to #{current_user.email}"
    mail(to: @user.email, subject: "BTTC reservation created!")
  end
end
