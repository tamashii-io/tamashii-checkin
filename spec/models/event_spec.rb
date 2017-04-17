# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:attendees) }
  it { should have_many(:check_points) }
end
