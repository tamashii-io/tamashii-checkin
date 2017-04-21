# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  validates :name, presence: true
  has_many :attendees
  has_many :check_points
  has_many :check_records, through: :check_points
  has_many :machines, through: :check_points
  scope :now, -> { where('? BETWEEN start_at AND end_at', Time.zone.now) }
  scope :overlap, ->(range) { where('TSRANGE(start_at, end_at) && TSRANGE(?, ?)', range.begin, range.end) }

  def peroid
    start_at..end_at
  end
end
