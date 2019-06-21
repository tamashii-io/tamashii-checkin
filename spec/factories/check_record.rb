# frozen_string_literal: true

FactoryBot.define do
  factory :check_record do
    times { 1 }
    check_point { create(:check_point) }
    attendee { create(:attendee) }
  end
end
