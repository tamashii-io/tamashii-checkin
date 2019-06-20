# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  it { should have_many(:check_records) }
  it { should belong_to(:event) }
  it { should belong_to(:machine) }
  it { should belong_to(:registrar) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }

  subject { create(:check_point) }
  let(:attendee) { create(:attendee, event_id: subject.event_id) }

  describe '#checkin' do
    it 'no check_record' do
      expect { subject.checkin(attendee) }.to change { CheckRecord.count }.by(1)
    end

    it 'has check_record exclude -INFINITY..specific.ago' do
      subject.checkin(attendee)
      expect { subject.checkin(attendee) }.to change { CheckRecord.count }.by(0)
    end
  end

  let(:machine) { create(:machine) }
  let(:event) { create(:event) }
  let(:check_point) { create(:check_point, name: 'name', machine_id: machine.id, event_id: event.id) }

  describe '#machine_available' do
    let(:machines) { create_list(:machine, 2) }
    let(:event_a) { create(:event, name: 'name', start_at: '2015-04-11 09:27:00', end_at: '2015-04-13 09:27:00') }
    let(:event_b) { create(:event, name: 'name', start_at: '2015-04-14 09:27:00', end_at: '2015-04-16 09:27:00') }
    let(:event_c) { create(:event, name: 'name', start_at: '2015-04-15 09:27:00', end_at: '2015-04-20 09:27:00') }

    it 'available machine' do
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_a.id)).to be_valid
    end

    it 'reuse machine' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_a.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_a.id)).not_to be_valid
    end

    it 'two event separate' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_a.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)).to be_valid
    end

    it 'two event overlap' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_c.id)).not_to be_valid
      expect(build(:check_point, name: 'name', machine_id: machines[1].id, event_id: event_c.id)).to be_valid
    end

    it 'three event overlap1' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_a.id)).to be_valid
    end

    it 'three event overlap2' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)).not_to be_valid
    end

    it 'three event overlap3' do
      create(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_b.id)
      expect(build(:check_point, name: 'name', machine_id: machines[0].id, event_id: event_c.id)).not_to be_valid
    end
  end

  describe '#latest_record' do
    it 'no active record' do
      expect { subject.latest_record(attendee) }.to change { CheckRecord.count }.by(1)
    end

    it 'have active record' do
      create(:check_record, attendee_id: attendee.id, check_point_id: subject.id)
      expect { subject.latest_record(attendee) }.to change { CheckRecord.count }.by(0)
    end
  end

  it '#to_s' do
    expect(subject.to_s).to eq(subject.name)
  end
end
