# frozen_string_literal: true

FactoryGirl.define do
  factory :machine do
    name { Faker::Name.name }
    serial { Faker::Device.serial }
    created_at {}
    updated_at {}
  end
end
