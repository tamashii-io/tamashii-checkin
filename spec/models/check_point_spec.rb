# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  describe '#checkin' do
    subject { create(:check_point) }
    let(:attendee) { create(:attendee, event_id: subject.event_id) }

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

  it 'validates title' do
    expect(build(:check_point, name: nil, machine_id: machine.id, event_id: event.id)).not_to be_valid
    expect(build(:check_point, name: 'name', machine_id: machine.id, event_id: event.id)).to be_valid
  end

  it 'belongs to machines' do
    expect(machine.check_points).to include(check_point)
  end

  it 'belongs to events' do
    expect(event.check_points).to include(check_point)
  end

  describe 'machine_available_test' do
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
end
