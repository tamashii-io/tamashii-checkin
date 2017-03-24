# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  validates :name, presence: true
end
