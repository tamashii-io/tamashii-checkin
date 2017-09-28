# frozen_string_literal: true
# Registrar Channel
class RegistrarChannel < ApplicationCable::Channel
  EVENTS = {
    register: 'REGISTER',
    success: 'REGISTER_SUCCESS',
    update: 'REGISTER_UPDATE'
  }.freeze

  class << self
    def register(registrar, serial, packet_id)
      broadcast_to(registrar, type: EVENTS[:register], serial: serial, packet_id: packet_id)
    end

    def update(attendee)
      serializable_attendee = ActiveModelSerializers::SerializableResource.new(attendee)
      broadcast_to(attendee.event, type: EVENTS[:update], attendee: serializable_attendee.as_json)
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

  # TODO: Improve this method AbcSize
  # rubocop:disable Metrics/AbcSize
  def register(data)
    attendee = Attendee.find(data['attendeeId'])
    packet_id = data['packet_id']
    serial = data['serial']
    machine = attendee.event.machines.find_by(check_points: { registrar: current_user })
    return response_register_status(machine, packet_id, false) unless attendee.register(serial)
    RegistrarChannel.broadcast_to([current_user, attendee.event], type: EVENTS[:success], attendee: attendee)
    response_register_status(machine, packet_id, true)
  end
  # rubocop:enable Metrics/AbcSize

  private

  # TODO: Move into model or tamashii hooks
  def response_register_status(machine, packet_id, success)
    machine.write Tamashii::Packet.new(
      30,
      0,
      build_register_packet(packet_id, success)
    )
  end

  def build_register_packet(packet_id, success)
    {
      id: packet_id,
      ev_body: {
        auth: success,
        reason: 'registrar'
      }.to_json
    }.to_json
  end
end
