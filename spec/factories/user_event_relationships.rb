# frozen_string_literal: true
FactoryGirl.define do
  factory :user_event_relationship do
    user nil
    event nil
    role 1
  end
end
