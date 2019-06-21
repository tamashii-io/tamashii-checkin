# frozen_string_literal: true

FactoryBot.define do
  factory :machine do
    name { Faker::Name.name }
    serial { Faker::Device.unique.serial }
  end
end
