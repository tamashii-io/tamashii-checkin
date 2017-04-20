# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPoint < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  self.inheritance_column = :_type

  has_many :check_records
  belongs_to :event
  belongs_to :machine

  validates :name, presence: true
  validate :machine_available

  def checkin(attendee)
    latest_record(attendee).increment
  end

  def machine_available
    return unless machine.events.overlap(event.peroid).any?
    errors.add(:machine, '這時間已經有人使用此機器')
  end

  def latest_record(attendee)
    check_records.active.first_or_create(attendee: attendee)
  end
end
