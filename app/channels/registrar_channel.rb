# frozen_string_literal: true
# Registrar Channel
class RegistrarChannel < ApplicationCable::Channel
  EVENTS = {
    register: 'REGISTER',
    success: 'REGISTER_SUCCESS',
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def register(registrar, serial)
      broadcast_to(registrar, type: EVENTS[:register], serial: serial)
    end

    def update(attendee)
      broadcast_to(attendee.event, type: EVENTS[:update], attendee: attendee)
    end
  end

  def follow(data)
    stop_all_streams
    event = Event.find(data['event_id'])
    stream_for event
    stream_for [current_user, event]
  end

  def unfollow
    stop_all_streams
  end

  def register(data)
    attendee = Attendee.find(data['attendeeId'])
    serial = data['serial']
    return unless attendee.register(serial)
    RegistrarChannel.broadcast_to([current_user, attendee.event], type: EVENTS[:success], attendee: attendee)
  end
end
