# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:attendees) }
  it { should have_many(:check_points) }
  it { should have_many(:check_records) }
  it { should have_many(:machines) }
  it { should have_many(:user_event_relationships) }
  it { should have_many(:staffs) }
  it { should validate_presence_of(:name) }

  subject { create(:event) }
  let(:event_without_name) { Event.new(name: nil) }

  it '#peroid' do
    expect(subject.peroid).to eq(Range.new(subject.start_at, subject.end_at))
  end

  it '#to_s' do
    expect(subject.to_s).to eq(subject.name)
  end

  describe '.now' do
    it 'not include expired event' do
      expired_event = create(:event, start_at: 4.days.ago, end_at: 1.day.ago)
      expect(Event.now).not_to include(expired_event)
    end

    it 'include activity event' do
      event = create(:event, start_at: 4.days.ago, end_at: Time.zone.now + 1.day)
      expect(Event.now).to include(event)
    end
  end

  describe '.overlap' do
    it 'not in the range' do
      event = create(:event, start_at: 10.days.ago, end_at: 7.days.ago)
      range = Range.new(Time.zone.now, Time.zone.now + 5.days)
      expect(Event.overlap(range)).not_to include(event)
    end

    it 'in the range' do
      event = create(:event, start_at: 2.days.ago, end_at: Time.zone.now + 1.day)
      range = Range.new(Time.zone.now, Time.zone.now + 5.days)
      expect(Event.overlap(range)).to include(event)
    end
  end
end
