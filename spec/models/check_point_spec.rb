# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  describe '#checkin' do
    subject { create(:check_point) }
    let(:attendee) { create(:attendee, event_id: subject.event_id) }

    it 'no check_record' do
      expect { subject.checkin(attendee.id) }.to change { CheckRecord.count }.by(1)
    end

    it 'has check_record exclude -INFINITY..specific.ago' do
      checkrecord = create(:check_record, check_point_id: subject.id, attendee_id: attendee.id)
      expect { subject.checkin(checkrecord.attendee_id) }.to change { CheckRecord.first.times }.by(1)
    end
  end
end
