# frozen_string_literal: true

log_file = Rails.logger.instance_variable_get(:@logdev)&.dev || Rails.root.join('log', 'action_cable.log')
ActionCable.server.config.logger = Logger.new(log_file)
ActionCable.server.config.logger.level = Logger::WARN
