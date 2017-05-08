# frozen_string_literal: true
# Registrar Channel
class EventAttendeesDashboardChannel < ApplicationCable::Channel
  EVENTS = {
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def update(attendee)
      broadcast_to(attendee.event, type: EVENTS[:update], attendee: attendee)
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
