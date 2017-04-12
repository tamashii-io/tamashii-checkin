# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  validates :name, presence: true
  has_many :attendee
  has_many :check_point
end
