# frozen_string_literal: true

Tamashii::Manager.config do |config|
  config.env = Rails.env
  config.auth_type = Settings.tamashii.mode
  config.token = Settings.tamashii.token
end

Tamashii::Resolver.config do
  hook TamashiiRailsHook
end
