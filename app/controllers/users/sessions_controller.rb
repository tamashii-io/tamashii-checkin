# frozen_string_literal: true
module Users
  # Session Controller
  class SessionsController < Devise::SessionsController
    layout 'session'
  end
end
