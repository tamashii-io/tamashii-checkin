# frozen_string_literal: true
require_relative 'tamashii/manager/client'

# Tamashii Rails Hook
class TamashiiRailsHook < Tamashii::Hook
  INTERESTED_TYPES = [Tamashii::Type::RFID_NUMBER, Tamashii::Type::RFID_DATA].freeze

  def initialize(*args)
    super
    @client = @env[:client]
  end

  def call(packet)
    return unless @client.authorized?
    return unless interested?(packet)

    # rubocop:disable Rails/SkipsModelValidations
    Tamashii::Machine.new(@client.id).touch
    # rubocop:enable Rails/SkipsModelValidations

    Tamashii::Manager.logger.debug "Tamashii #{packet.type} Packet captured by Rails, #{packet.body}"
    handle(packet)
    # TODO: Save recent update information into Redis
    # machine&.touch
    true
  end

  def machine
    Machine.find_by(serial: @client.id)
  end

  def handle(packet)
    type, data = case packet.type
                 when Tamashii::Type::RFID_NUMBER
                   Tamashii::CardHandler.new(@client, packet).process
                 end
    response type, data
  end

  def response(type, data)
    packet = Tamashii::Packet.new(type, @client.tag, data)
    @client.send(packet.dump)
  end

  private

  def interested?(packet)
    INTERESTED_TYPES.include?(packet.type)
  end
end
