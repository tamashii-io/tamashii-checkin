# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  has_many :attendees
  has_many :check_points
  has_many :check_records, through: :check_points
  has_many :machines, through: :check_points
  has_many :user_event_relationships
  has_many :staffs, through: :user_event_relationships, source: :user

  scope :now, -> { where('? BETWEEN start_at AND end_at', Time.zone.now) }
  scope :overlap, ->(range) { where('TSRANGE(start_at, end_at) && TSRANGE(?, ?)', range.begin, range.end) }

  validates :name, presence: true

  def peroid
    start_at..end_at
  end

  def to_s
    name
  end
end
