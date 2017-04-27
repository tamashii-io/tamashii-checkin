# frozen_string_literal: true
# missing top-level class documentation comment
class CheckrecordsChannel < ApplicationCable::Channel
  # def subscribed
  #   # stream_from "some_channel"
  #   stream_from 'checkrecords_channel'
  # end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
  EVENTS = {
    register: 'REGISTER',
    success: 'REGISTER_SUCCESS',
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def register(registrar, serial)
      broadcast_to(registrar, type: EVENTS[:register], check_record: check_record)
    end

    def update(check_record)
      broadcast_to(check_record.event, type: EVENTS[:update], check_record: check_record)
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
    check_record = CheckRecord.find(data['check_recordId'])
    serial = data['serial']
    return unless check_record.register(serial)
    CheckrecordsChannel.broadcast_to([current_user, check_record.event], type: EVENTS[:success], attendee: attendee)
  end
end
