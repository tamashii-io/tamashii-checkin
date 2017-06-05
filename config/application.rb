# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module TamashiiCheckin
  # missing top-level class documentation comment
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :"zh-TW"

    config.sass.load_paths << Rails.root.join('vendor', 'coreui')
    config.autoload_paths << Rails.root.join('app', 'tamashii')

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths << Rails.root.join('app', 'api', '*')
  end
end
