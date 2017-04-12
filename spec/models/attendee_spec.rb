# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it 'belongs to event' do
    create(:attendee)
    expect(Attendee.first.event).to eq(Event.first)
  end

  it 'has many check_record' do
    attendee = create(:attendee)
    create(:check_record, attendee_id: attendee.id)
    expect(Attendee.first.check_record).to include(CheckRecord.first)
  end
end
