# frozen_string_literal: true

FactoryGirl.define do
  factory :attendee do
    id { Faker::Number.number(6) }
    sequence :serial
    name { Faker::Name.name }
    code { Faker::Code.asin }
    email { Faker::Code.asin }
    phone { Faker::Code.asin }
    note { Faker::Code.asin }
    card_serial {}
    event_id {}
    created_at {}
    updated_at {}
    association :event, factory: :event
  end
end
