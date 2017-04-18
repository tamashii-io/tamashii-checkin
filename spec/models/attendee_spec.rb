# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it { should have_many(:check_records) }

  it { should belong_to(:event) }
end
