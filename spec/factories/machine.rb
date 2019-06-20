# frozen_string_literal: true

FactoryGirl.define do
  factory :machine do
    id { Faker::Number.number(6) }
    name { Faker::Name.name }
    serial { Faker::Code.asin }
    created_at {}
    updated_at {}
  end
end
