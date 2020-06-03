class MembershipMailer < ApplicationMailer

  def membership_end_email(user)
    @user = user

    mail(to: @user.email, subject: "Your membership has ended!")
  end

end
