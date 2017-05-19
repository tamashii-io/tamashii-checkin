# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it { should have_many(:check_records) }
  it { should belong_to(:event) }

  let!(:attendee) { create(:attendee) }
  let!(:attendee_card_serial) { create(:attendee, card_serial: '1234') }

  it '.not_checked_in' do
    expect(Attendee.not_checked_in).to eq(1)
  end

  it '#to_s' do
    expect(attendee.to_s).to eq(attendee.name)
  end

  it '#register' do
    attendee.register('ABCD')
    attendee_card_serial.register('ABCD')
    expect(attendee.card_serial).to eq('ABCD')
    expect(attendee_card_serial.card_serial).to eq('1234')
  end
end
