# frozen_string_literal: true
FactoryGirl.define do
  factory :machine do
    id { Faker::Number.number(6) }
    name { Faker::Name.name }
    serial { Faker::Code.asin }
    created_at { Faker::Date.between(10.days.ago, 2.days.ago) }
    updated_at { Faker::Date.between(2.days.ago, Time.zone.today) }
  end
end
