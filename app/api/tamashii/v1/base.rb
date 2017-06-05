# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class Base < Grape::API
      version 'v1', using: :path
      format :json

      mount Tamashii::V1::Events
    end
  end
end
