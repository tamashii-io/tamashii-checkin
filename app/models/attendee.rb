# frozen_string_literal: true
# missing top-level class documentation comment
class Attendee < ApplicationRecord
  belongs_to :event
  has_many :check_records

  after_save -> { RegistrarChannel.update(self) }

  def register(serial)
    return if card_serial.present?
    update_attributes(card_serial: serial)
  end
end
