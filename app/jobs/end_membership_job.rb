class EndMembershipJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later

    if user.membership_end_date < DateTime.today
      user.update(member?: false)
      MembershipMailer.membership_end_email(user).deliver_later
    end

  end
end
