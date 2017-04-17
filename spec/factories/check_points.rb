# frozen_string_literal: true
FactoryGirl.define do
  factory :check_point do
    id { Faker::Number.number(6) }
    name { Faker::Name.name }
    type 1
    machine_id {}
    event_id {}
    created_at {}
    updated_at {}
    association :event, factory: :event
    association :machine, factory: :machine
  end
end
