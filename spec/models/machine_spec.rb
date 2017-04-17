# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Machine, type: :model do
  it { should have_many(:check_point) }
end
