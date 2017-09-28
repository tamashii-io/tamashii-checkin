# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class CheckPoints < Grape::API
      resources :check_points do
        desc 'CheckPoint List'
        get '/' do
          Event.find(params[:event_id]).check_points.as_json(only: [:id, :name])
        end
      end
    end
  end
end
