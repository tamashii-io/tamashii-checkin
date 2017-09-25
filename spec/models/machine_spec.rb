# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Machine, type: :model do
  it { should have_many(:check_points) }
  it { should validate_uniqueness_of(:serial) }

  describe 'current_event_check_point' do
    let(:machine_a) { create(:machine, name: 'qquio') }
    let(:machine_b) { create(:machine) }
    let(:event_a) { create(:event, name: 'name', start_at: '2015-04-11 09:27:00', end_at: '2019-04-13 09:27:00') }
    let(:event_b) { create(:event, name: 'name', start_at: '2020-04-11 09:27:00', end_at: '2022-04-13 09:27:00') }
    it 'find_check_point' do
      check_point = create(:check_point, name: 'name', machine_id: machine_a.id, event_id: event_a.id)
      expect(machine_a.current_event_check_point).to eq(check_point)
    end
    it 'wrong_machine' do
      check_point = create(:check_point, name: 'name', machine_id: machine_a.id, event_id: event_a.id)
      expect(machine_b.current_event_check_point).not_to eq(check_point)
    end
    it 'wrong_event_time' do
      check_point = create(:check_point, name: 'name', machine_id: machine_a.id, event_id: event_b.id)
      expect(machine_a.current_event_check_point).not_to eq(check_point)
    end
  end
end
