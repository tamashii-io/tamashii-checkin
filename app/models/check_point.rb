# frozen_string_literal: true

# :nodoc:
class CheckPoint < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  self.inheritance_column = :_type

  has_many :check_records
  belongs_to :event
  belongs_to :machine
  # TODO: wait !77 PR, only have permissions User can choice
  belongs_to :registrar, class_name: 'User', optional: true

  validates :name, :type, presence: true
  validates :registrar, uniqueness: { scope: :event_id }
  validate :machine_available, on: :create

  # TODO: Implements STI class to work with different behavior
  enum type: {
    registrar: 0,
    site: 1,
    gate: 2
  }

  def register(card_serial, packet_id)
    return false if event.attendees.where(card_serial: card_serial).exists?
    return false if registrar.blank?
    RegistrarChannel.register([registrar, event], card_serial, packet_id)
    nil
  end

  def checkin(attendee)
    return false if attendee.blank?
    latest_record(attendee).increment
    true
  end

  def check_pass(attendee)
    AccessesChannel.request(self, attendee)
    false
  end

  # TODO: Move to Gate type model
  def grant_access(attendee, accept = false)
    if accept
      accept(attendee)
    else
      reject
    end
    AccessesChannel.update_access(self)
    self
  end

  def machine_available
    return if machine.blank?
    return unless machine.events.overlap(event.peroid).any?
    errors.add(:machine, '這時間已經有人使用此機器')
  end

  def latest_record(attendee)
    check_records.active.find_or_create_by(attendee: attendee)
  end

  def to_s
    name
  end

  private

  def accept(attendee)
    latest_record(attendee).increment
    machine.lcd_message("Hi, #{attendee.email.slice!(/[^@]+/)}\nAccess granted")
    machine.beep
  end

  def reject
    machine.lcd_message("Sorry!\nAccess denind")
    machine.beep('no')
  end
end
