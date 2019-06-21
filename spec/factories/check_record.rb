# frozen_string_literal: true

FactoryGirl.define do
  factory :check_record do
    times 1
    association :check_point, factory: :check_point
    association :attendee, factory: :attendee
  end
end
