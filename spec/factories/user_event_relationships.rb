# frozen_string_literal: true

FactoryBot.define do
  factory :user_event_relationship do
    user { create(:user) }
    event { create(:event) }
  end
end
