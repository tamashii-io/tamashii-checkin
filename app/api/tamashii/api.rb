# frozen_string_literal: true

module Tamashii
  # :nodoc:
  class API < Grape::API
    prefix :api

    Grape::Middleware::Auth::Strategies.add(:event_auth, EventAuthMiddleware)

    mount Tamashii::V1::Base

    add_swagger_documentation if Rails.env.development?
  end
end
