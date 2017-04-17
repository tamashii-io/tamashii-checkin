# frozen_string_literal: true
# missing top-level class documentation comment
class Attendee < ApplicationRecord
  belongs_to :event
  has_many :check_records
end
