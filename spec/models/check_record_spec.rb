# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckRecord, type: :model do
  it { should belong_to(:attendee) }

  it { should belong_to(:check_point) }

  subject { create(:check_record) }
  describe '.active' do
    it 'not exceed the time limit' do
      expect(CheckRecord.active).to include(subject)
    end

    it 'exceed the time limit' do
      subject.update(updated_at: 5.days.ago)
      expect(CheckRecord.active).not_to include(subject)
    end
  end

  it '#increment' do
    expect { subject.increment }.to change { subject.times }.by(1)
  end
end
