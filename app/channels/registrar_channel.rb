# frozen_string_literal: true
# Registrar Channel
class RegistrarChannel < ApplicationCable::Channel
  EVENTS = {
    register: 'REGISTER'
  }.freeze

  class << self
    def register(registrar, serial)
      broadcast_to(registrar, event: EVENTS[:register], serial: serial)
    end
  end

  def follow(data)
    stop_all_streams
    event = Event.find(data['event_id'])
    logger.info "Following #{event.name}"
    stream_for [current_user, event]
  end

  def unfollow
    stop_all_streams
  end
end
