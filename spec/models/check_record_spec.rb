# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckRecord, type: :model do
  it 'belongs to checkpoint and attendee' do
    create(:check_record)
    expect(CheckRecord.first.attendee.id).to eq(Attendee.first.id)
    expect(CheckRecord.first.check_point.id).to eq(CheckPoint.first.id)
  end

  it '#increment' do
    checkrecord = create(:check_record)
    expect { checkrecord.increment }.to change { checkrecord.times }.by(1)
  end
end
