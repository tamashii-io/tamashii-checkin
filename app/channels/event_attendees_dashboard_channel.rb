# frozen_string_literal: true

# Registrar Channel
class EventAttendeesDashboardChannel < ApplicationCable::Channel
  EVENTS = {
    update: 'REGISTER_UPDATE',
    poll_summary: 'POLL_SUMMARY'
  }.freeze

  class << self
    def update(attendee)
      serializable_attendee = ActiveModelSerializers::SerializableResource.new(attendee)
      broadcast_to(attendee.event, type: EVENTS[:update], attendee: serializable_attendee.as_json)
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

  def update_summary(data)
    time_interval = data['time_interval'] || 1.minute
    event = Event.find(data['event_id'])
    data = event.check_point_summary(time_interval)
    self.class.broadcast_to(event, type: EVENTS[:poll_summary], summary: data, time_interval: time_interval)
  end
end
