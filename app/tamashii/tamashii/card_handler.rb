# frozen_string_literal: true

module Tamashii
  # Tamashii::CardHandler
  class CardHandler
    class CardError < RuntimeError; end
    class InvalidCardError < CardError; end
    class UnregisterMachineError < CardError; end

    attr_reader :card_id, :packet_id

    def initialize(client, packet)
      @client = client
      @packet = packet
      @packet_id, @card_id = unpack
    end

    def process
      raise InvalidCardError, 'Invalid Card' if card_id.blank?
      raise UnregisterMachineError, 'Unregister Machine' if machine.blank?
      return response auth: false, reason: 'No Checkpoint Available' if check_point.blank?

      perform
    rescue CardError => e
      response auth: false, reason: e.message
    rescue ActiveRecord::RecordNotFound => e
      response auth: false, reason: e.message
    end

    private

    def response(**body)
      [Tamashii::Type::RFID_RESPONSE_JSON, pack(body)]
    end

    def pack(body)
      {
        id: packet_id,
        ev_body: body.to_json
      }.to_json
    end

    def unpack
      json = JSON.parse(@packet.body)
      [json['id'], json['ev_body']]
    end

    def machine
      @machine ||= ::Machine.find_by(serial: @client.id)
    end

    def check_point
      machine.current_event_check_point
    end

    def attendee
      machine.current_event.attendees.find_by(card_serial: card_id)
    end

    def registrar
      result = check_point.register(card_id, packet_id)
      return [nil, nil] if result.nil?

      response auth: result, reason: 'registrar', message: "New card\nDetected."
    end

    def site
      result = check_point.checkin(attendee)
      response auth: result, reason: 'checkin', message: result ? "Hello, #{attendee.name}!\nChecking success" : 'Unknown card'
    end

    def gate
      result = check_point.check_pass(attendee)
      response auth: result, reason: 'gate', message: "Hi, #{attendee.name}\nRequest sent."
    end

    def perform
      send(check_point.type)
    end
  end
end
