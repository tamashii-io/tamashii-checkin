# frozen_string_literal: true
module Tamashii
  # Tamashii::Commander
  class Commander
    class CommandError < RuntimeError; end

    COMMANDS = {
      beep:     Tamashii::Type::BUZZER_SOUND,
      restart:  Tamashii::Type::RESTART,
      reboot:   Tamashii::Type::REBOOT,
      poweroff: Tamashii::Type::POWEROFF,
      update:   Tamashii::Type::UPDATE
    }.freeze

    def initialize(machine, command)
      @machine = machine
      @command = command.to_sym
    end

    def process(options = nil)
      raise CommandError, 'Client didn\'t exists' if client.nil?
      type, body = build_command(options)
      packet = Tamashii::Packet.new(type, client.tag, body)
      client.send(packet.dump)
    end

    private

    def build_command(options)
      type = command_to_type
      body = pack(options)
      raise CommandError, 'Invalid Command' if type.nil?
      [type, body]
    end

    def command_to_type
      COMMANDS[@command]
    end

    def pack(options)
      return options if options.is_a?(String)
      return options.to_json if options.is_a?(Hash) || options.is_a?(Array)
      ''
    end

    def client
      @client ||= Tamashii::Manager::Client.accepted_clients[@machine.serial]
    end
  end
end