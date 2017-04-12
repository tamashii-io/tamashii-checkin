# frozen_string_literal: true
FactoryGirl.define do
  factory :check_record do
    id { Faker::Number.number(6) }
    check_point_id {}
    attendee_id {}
    times 1
    created_at { Faker::Date.between(10.days.ago, 8.days.ago) }
    updated_at { Faker::Date.between(7.days.ago, 6.days.ago) }
    association :check_point, factory: :check_point
    association :attendee, factory: :attendee
  end
end
