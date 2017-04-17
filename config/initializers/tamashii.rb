# frozen_string_literal: true
Tamashii::Manager.config do
  env Rails.env
  auth Settings.tamashii.mode
  token Settings.tamashii.token
end

Tamashii::Resolver.config do
  hook TamashiiRailsHook
end
