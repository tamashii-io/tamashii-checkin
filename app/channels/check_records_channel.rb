# frozen_string_literal: true

# :nodoc:
class CheckRecordsChannel < ApplicationCable::Channel
  EVENTS = {
    update: 'CHECK_RECORD_UPDATE',
    set: 'CHECK_RECORD_SET'
  }.freeze

  class << self
    def update(check_record)
      broadcast_to(check_record.check_point.event, type: EVENTS[:update], check_record: check_record.as_json(include: [:attendee, :check_point]))
    end

    def set(check_record)
      broadcast_to(check_record.check_point.event, type: EVENTS[:set], check_record: check_record.as_json(include: [:attendee, :check_point]))
    end
  end

  def follow(data)
    stop_all_streams
    event = Event.find(data['event_id'])
    stream_for event
  end

  def unfollow
    stop_all_streams
  end
end
