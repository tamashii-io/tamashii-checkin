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

      alias origin_accept accept
      def accept(type, id)
        origin_accept(type, id)
        ::Machine.find_by(serial: id).on_accept
      end

      # Overrite the on_close methods
      alias origin_on_close on_close
      def on_close
        Tamashii::Machine.new(id).close
        origin_on_close
      end
    end
  end
end
