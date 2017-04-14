# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckRecord, type: :model do
  it { should belong_to(:attendee) }

  it { should belong_to(:check_point) }

  subject { create(:check_record) }
  it '#increment' do
    expect { subject.increment }.to change { subject.times }.by(1)
  end
end
