# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it { should have_many(:check_records) }
  it { should belong_to(:event) }

  let!(:attendee) { create(:attendee) }
  let!(:attendee_card_serial) { create(:attendee, card_serial: '1234') }

  it '.not_checked_in' do
    expect(Attendee.not_checked_in.count).to eq(1)
  end

  it '#to_s' do
    expect(attendee.to_s).to eq(attendee.name)
  end

  describe '#register' do
    it 'have card_serial can not override' do
      attendee_card_serial.register('ABCD')
      expect(attendee_card_serial.card_serial).not_to eq('ABCD')
    end

    it 'without card_serial then write serial' do
      attendee.register('ABCD')
      expect(attendee.card_serial).to eq('ABCD')
    end
  end
end
