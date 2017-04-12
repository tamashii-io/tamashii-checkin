# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  describe '#checkin' do
    it '#checkin no check_record' do
      checkpoint = create(:check_point)
      attendee = create(:attendee)
      expect { checkpoint.checkin(attendee.id) }.to change { CheckRecord.count }.by(1)
    end

    it '#checkin has check_record exclude -INFINITY..specific.ago' do
      checkpoint = create(:check_point)
      checkrecord = create(:check_record, check_point_id: checkpoint.id)
      expect { checkpoint.checkin(checkrecord.attendee_id) }.to change { CheckRecord.first.times }.by(1)
    end

    it '#checkin has check_record include -INFINITY..specific.ago' do
      checkpoint = create(:check_point)
      checkrecord = create(:check_record, check_point_id: checkpoint.id, updated_at: 10.days.ago)
      expect { checkpoint.checkin(checkrecord.attendee_id) }.to change { CheckRecord.count }.by(1)
    end
  end
end
