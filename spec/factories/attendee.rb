# frozen_string_literal: true

FactoryBot.define do
  factory :attendee do
    sequence :serial
    name { Faker::Name.name }
    code { Faker::Code.asin }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    event { create(:event) }
  end
end
