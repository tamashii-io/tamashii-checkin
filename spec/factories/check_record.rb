# frozen_string_literal: true
FactoryGirl.define do
  factory :check_record do
    id { Faker::Number.number(6) }
    check_point_id {}
    attendee_id {}
    times 1
    created_at { Faker::Date.between(Time.zone.today, Time.zone.today) }
    updated_at { Faker::Date.between(Time.zone.today, Time.zone.today) }
    association :check_point, factory: :check_point
    association :attendee, factory: :attendee
  end
end
