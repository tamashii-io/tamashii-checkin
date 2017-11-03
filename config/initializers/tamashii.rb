# frozen_string_literal: true

# TODO: Set same log path for Tamashii::Manager and Server
Tamashii::Server.config.log_path = Rails.root.join('log', 'tamashii.log')

Tamashii::Manager.config do |config|
  config.env = Rails.env
  config.log_level = Logger::WARN
  config.log_file = Rails.root.join('log', 'tamashii.log')
  config.auth_type = Settings.tamashii.mode
  config.token = Settings.tamashii.token
end

Tamashii::Resolver.config do
  hook TamashiiRailsHook
end
