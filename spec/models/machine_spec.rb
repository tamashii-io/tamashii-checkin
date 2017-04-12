# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Machine, type: :model do
  it 'has many check_point' do
    machine = create(:machine)
    create(:check_point, machine_id: machine.id)
    expect(Machine.first.check_point).to include(CheckPoint.first)
  end
end
