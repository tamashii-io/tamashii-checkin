# frozen_string_literal: true

module Tamashii
  # Tamashii::Machine
  class Machine
    HASH_KEY = 'tamashii-machines'
    LAST_UPDATE_KEY = 'tamashii-last-broadcast'

    def initialize(serial)
      @serial = serial
    end

    def touch
      time = Time.zone.now
      redis.hset(HASH_KEY, @serial, time)
      cable_broadcast_update(time)
    end

    def last_active
      Time.zone.parse redis.hget(HASH_KEY, @serial)
    rescue ArgumentError
      nil
    end

    def close
      redis.hdel(HASH_KEY, @serial)
      cable_broadcast_close
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

    def broadcast_update?
      last_time = redis.get(LAST_UPDATE_KEY) || (Time.current - 1.minute).to_s
      Time.current >= Time.zone.parse(last_time) + 1.minute
    end

    def build_broadcast_event(serial, time, activites)
      {
        last_active: time,
        serial: serial,
        type: 'LAST_ACTIVE_CHANGED',
        total: activites
      }
    end

    def broadcast_all_update
      serials = ::Machine.all.pluck(:serial)
      serials.each do |serial|
        time = redis.hget(HASH_KEY, serial)
        cable_broadcast build_broadcast_event(serial, time, serials.size) if time
      end
      redis.set(LAST_UPDATE_KEY, Time.current)
    end

    def cable_broadcast_update(_time)
      return if @serial.match?(/Unauthorized/)
      return unless broadcast_update?
      broadcast_all_update
    end

    def cable_broadcast_close
      event = {
        serial: @serial,
        type: 'SHUTDOWN',
        total: Machine.activities.count
      }

      cable_broadcast event
    end

    def cable_broadcast(event)
      ActionCable.server.broadcast 'machines', event
    end
  end
end
