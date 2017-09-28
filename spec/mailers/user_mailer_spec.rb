# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'notify_new_staff' do
    let(:event) { FactoryGirl.create(:event) }
    let(:inviter) { FactoryGirl.create(:user) }
    let(:invitee) { FactoryGirl.create(:user, password: invitee_password) }
    let(:invitee_password) { Devise.friendly_token.first(8) }

    let(:mail) { UserMailer.notify_new_staff(event, inviter, invitee, invitee_password) }

    it "contains new user's email and password" do
      expect(mail.body.encoded).to match(invitee.email)
      expect(mail.body.encoded).to match(invitee_password)
    end
  end
end
