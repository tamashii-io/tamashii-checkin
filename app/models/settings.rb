# frozen_string_literal: true
# Settings
class Settings < Settingslogic
  source Rails.root.join('config', 'settings.yml')
  namespace Rails.env
end
