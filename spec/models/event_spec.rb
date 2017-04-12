# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has many attendee' do
    event = create(:event)
    create(:attendee, event_id: event.id)
    expect(Event.first.attendee).to include(Attendee.first)
  end

  it 'has many check_point' do
    event = create(:event)
    create(:check_point, event_id: event.id)
    expect(Event.first.check_point).to include(CheckPoint.first)
  end
end
