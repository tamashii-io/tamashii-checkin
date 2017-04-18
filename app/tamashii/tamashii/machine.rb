# frozen_string_literal: true
module Tamashii
  # Tamashii::Machine
  class Machine
    HASH_KEY = 'tamashii-machines'

    def initialize(serial)
      @serial = serial
    end

    def touch
      time = Time.zone.now
      redis.hset(HASH_KEY, @serial, time)
      broadcast_update(time)
    end

    def last_active
      Time.zone.parse redis.hget(HASH_KEY, @serial)
    rescue ArgumentError
      nil
    end

    def self.serials
      Redis.current.hkeys(HASH_KEY)
    end

    def self.activities
      keys = Redis.current.hkeys(HASH_KEY)
      values = Redis.current.hvals(HASH_KEY)
      Hash[keys.zip(values)]
    end

    private

    def redis
      Redis.current
    end

    def broadcast_update(time)
      event = {
        last_active: time,
        serial: @serial,
        event: 'LAST_ACTIVE_UPDATED'
      }

      ActionCable.server.broadcast 'machines', event
    end
  end
end
