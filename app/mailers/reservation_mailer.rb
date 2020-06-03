class ReservationMailer < ApplicationMailer
  def new_reservation_email(user, reservation)
    @reservation = reservation
    @user = user
    Rails.logger.warn "Sending email to #{@user.email}"
    mail(to: @user.email, subject: "BTTC reservation created!")
  end
end
