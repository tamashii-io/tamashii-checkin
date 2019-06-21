# frozen_string_literal: true

set :rails_env, 'production'
set :deploy_to, '/home/deploy/tamashii-staging.5xruby.tw'
set :default_env, path: '/usr/local/ruby-26/bin:$PATH'

server '10.128.128.222', user: 'deploy', roles: %w[app web db]
