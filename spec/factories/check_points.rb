# frozen_string_literal: true

FactoryBot.define do
  factory :check_point do
    name { Faker::Name.name }
    type { :site }
    event { create(:event) }
    machine { create(:machine) }
  end
end
