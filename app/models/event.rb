# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  validates :name, presence: true
  has_many :attendees
  has_many :check_point
end
