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

        desc 'CheckPoint Summary'
        params do
          requires :time_interval, type: Float
        end
        get 'summary' do
          Event.find(params[:event_id]).check_point_summary(params[:time_interval])
        end
      end
    end
  end
end
