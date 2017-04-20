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
      raise UnregisterMachineError, 'Unregister Machine' unless machine.present?
      # TODO: Handle Register
      response auth: true, reason: 'checkin'
    rescue CardError => e
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
  end
end
