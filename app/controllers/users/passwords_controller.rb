# frozen_string_literal: true

module Users
  # Passwords Controller
  class PasswordsController < Devise::PasswordsController
    layout 'session'
  end
end
