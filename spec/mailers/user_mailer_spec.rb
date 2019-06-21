# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'notify_new_staff' do
    let(:event) { FactoryBot.create(:event) }
    let(:inviter) { FactoryBot.create(:user) }
    let(:invitee) { FactoryBot.create(:user, password: invitee_password) }
    let(:invitee_password) { Devise.friendly_token.first(8) }

    let(:mail) { UserMailer.notify_new_staff(event, inviter, invitee, invitee_password) }

    it "contains new user's email and password" do
      expect(mail.body).to include(invitee.email)
      expect(mail.body).to include(invitee_password)
    end
  end
end
