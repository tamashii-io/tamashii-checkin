# frozen_string_literal: true

# missing top-level class documentation comment
class Attendee < ApplicationRecord
  store :note, accessors: %i[t_shirt ticket_type]

  belongs_to :event
  has_many :check_records

  after_save -> { update_channel }
  after_destroy -> { EventAttendeesDashboardChannel.update(self) }

  # TODO: this is a workaround for handle card_serial is NULL
  # After adding database default and model validation, it should be `where.not(card_serial: '')`
  # Validation could be: `validates :card_serial, prensence: { allow_blank: true }``
  scope :checked_in, -> { where("card_serial is not NULL and card_serial != ''") }

  def register(serial)
    return if card_serial.present?

    update(card_serial: serial)
  end

  def update_channel
    RegistrarChannel.update(self)
    EventAttendeesDashboardChannel.update(self)
  end

  def checked_in
    card_serial.present?
  end

  def attributes
    super.merge('checked_in' => checked_in)
  end

  def to_s
    name
  end

  def username
    email.slice(/[^@]+/)
  end
end
