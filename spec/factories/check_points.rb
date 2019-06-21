# frozen_string_literal: true

FactoryBot.define do
  factory :check_point do
    name { Faker::Name.name }
    type { :site }
    association :event, factory: :event
    association :machine, factory: :machine
  end
end
