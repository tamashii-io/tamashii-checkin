# frozen_string_literal: true

FactoryGirl.define do
  factory :attendee do
    sequence :serial
    name { Faker::Name.name }
    code { Faker::Code.asin }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    association :event, factory: :event
  end
end
