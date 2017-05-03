# frozen_string_literal: true
# missing top-level class documentation comment
class Attendee < ApplicationRecord
  belongs_to :event
  has_many :check_records

  after_save -> { update_channel }
  after_destroy -> { EventAttendeesDashboardChannel.update(self) }

  def register(serial)
    return if card_serial.present?
    update_attributes(card_serial: serial)
  end

  def update_channel
    RegistrarChannel.update(self)
    EventAttendeesDashboardChannel.update(self)
  end

  def to_s
    name
  end
end
