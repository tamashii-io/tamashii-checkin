# frozen_string_literal: true

FactoryGirl.define do
  factory :check_point do
    name { Faker::Name.name }
    type 1
    association :event, factory: :event
    association :machine, factory: :machine
  end
end
