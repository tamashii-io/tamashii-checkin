# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class Accesses < Grape::API
      resources :accesses do
        desc 'Update attendee access for check point'
        params do
          requires :attendee_id, type: Integer, desc: 'Attendee id.'
          requires :check_point_id, type: Integer, desc: 'Check Point id.'
          requires :accept, type: Boolean, desc: 'Is accept this user.'
        end
        post '/accesses' do
          # TODO: Implement full features
          event = Event.find(params[:event_id])
          check_point = event.check_points.find(params[:check_point_id])
          check_point.grant_access(Attendee.find(params[:attendee_id]), params[:accept])
        end
      end
    end
  end
end
