# frozen_string_literal: true

RSpec.configure do |config|
  config.after(:each) do
    Faker::UniqueGenerator.clear
  end
end
