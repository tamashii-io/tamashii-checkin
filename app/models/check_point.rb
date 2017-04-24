# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPoint < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  self.inheritance_column = :_type

  has_many :check_records
  belongs_to :event
  belongs_to :machine
  belongs_to :registrar, class_name: 'User', optional: true

  validates :name, :type, presence: true
  validate :machine_available, on: :create

  enum type: {
    registrar: 0,
    site: 1
  }

  def register(card_serial)
    return if event.attendees.where(card_serial: card_serial).exists?
    return unless registrar.present?
    RegistrarChannel.register([registrar, event], card_serial)
  end

  def checkin(attendee)
    return unless attendee.present?
    latest_record(attendee).increment
  end

  def machine_available
    return unless machine.present?
    return unless machine.events.overlap(event.peroid).any?
    errors.add(:machine, '這時間已經有人使用此機器')
  end

  def latest_record(attendee)
    check_records.active.first_or_create(attendee: attendee)
  end

  def to_s
    name
  end
end
