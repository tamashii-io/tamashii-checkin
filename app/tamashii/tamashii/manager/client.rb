# frozen_string_literal: true

module Tamashii
  module Manager
    # Tamashii::Manager::Client
    class Client
      # Override the original heartbeat callback...
      alias origin_heartbeat_callback heartbeat_callback
      def heartbeat_callback(*args, &block)
        origin_heartbeat_callback(*args, &block)
        # rubocop:disable Rails/SkipsModelValidations
        Tamashii::Machine.new(id).touch
        # rubocop:enable Rails/SkipsModelValidations
      end

      # Overrite the shutdown methods
      # alias origin_shutdown shutdown
      # def shutdown(*args, &block)
      #   origin_shutdown(*args, &block)
      #   Tamashii::Machine.new(id).close
      # end
    end
  end
end
