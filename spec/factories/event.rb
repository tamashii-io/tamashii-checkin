# frozen_string_literal: true

FactoryGirl.define do
  factory :event do
    id { Faker::Number.number(6) }
    name { Faker::Name.name }
    start_at { Faker::Date.between(100.days.ago, 11.days.ago) }
    end_at { Faker::Date.between(10.days.ago, Time.zone.today) }
    created_at {}
    updated_at {}
    user_id {}
  end
end
