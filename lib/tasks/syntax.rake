# frozen_string_literal: true

namespace :syntax do
  desc 'Fix frozen string error'
  task :frozen do
    sh 'bundle exec rubocop --auto-correct --only FrozenStringLiteralComment'
  end

  task :hash do
    sh 'bundle exec rubocop --auto-correct --only HashSyntax'
  end
end
