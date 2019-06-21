# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/notify_new_staff
  def notify_new_staff
    UserMailer.notify_new_staff(FactoryBot.build(:event), FactoryBot.build(:user), FactoryBot.build(:user), Devise.friendly_token.first(8))
  end
end
