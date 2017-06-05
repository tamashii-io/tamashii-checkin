# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class Events < Grape::API
      resources :events do
        route_param :event_id do
          mount Tamashii::V1::Attendees
          mount Tamashii::V1::Accesses
        end
      end
    end
  end
end
