# frozen_string_literal: true

set :rails_env, 'production'

set :deploy_to, '/home/deploy/tamashii-staging.5xruby.tw'
role :app, %w[deploy@10.128.128.153]
role :web, %w[deploy@10.128.128.153]
role :db, %w[deploy@10.128.128.153]

set :passenger_environment_variables, PASSENGER_INSTANCE_REGISTRY_DIR: '/var/lib/passenger-instreg'
