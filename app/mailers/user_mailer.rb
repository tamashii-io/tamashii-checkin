# frozen_string_literal: true
class UserMailer < ApplicationMailer
  def notify_new_staff(event, inviter, user, password)
    @event = event
    @inviter = inviter
    @user = user
    @password = password

    mail to: @user.email, from: @inviter.email, subject: "New staff notification for #{@event.name}"
  end
end
