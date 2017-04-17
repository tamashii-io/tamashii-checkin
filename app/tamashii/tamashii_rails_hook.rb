# frozen_string_literal: true
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

    Tamashii::Manager.logger.debug "Tamashii #{packet.type} Packet captured by Rails, #{packet.body}"
    handle(packet)
    # TODO: Save recent update information into Redis
    Machine.find_by(serial: @client.id)&.touch
    true
  end

  def handle(packet)
    # TODO: Implement handler
  end

  private

  def interested?(packet)
    INTERESTED_TYPES.include?(packet.type)
  end
end
