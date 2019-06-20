# frozen_string_literal: true

module ApplicationCable
  # ActionCable Connection
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user
      return reject_unauthorized_connection if verified_user.blank?

      verified_user
    end

    def verified_user
      env['warden'].user
    end
  end
end
