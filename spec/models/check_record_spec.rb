# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckRecord, type: :model do
  it { should belong_to(:attendee) }

  it { should belong_to(:check_point) }

  subject { create(:check_record) }
  it '.active' do
    expect(CheckRecord.active).to include(subject)
    subject.update_attributes(updated_at: 5.days.ago)
    expect(CheckRecord.active).not_to include(subject)
  end

  it '#increment' do
    expect { subject.increment }.to change { subject.times }.by(1)
  end

  it '#to_json' do
    json = subject.to_json
    expect(json['check_point']).to eq(subject.check_point)
    expect(json['attendee']).to eq(subject.attendee)
  end
end
