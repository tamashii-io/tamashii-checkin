# frozen_string_literal: true

FactoryBot.define do
  factory :machine do
    name { Faker::Name.name }
    serial { Faker::Device.serial }
  end
end
