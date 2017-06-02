# frozen_string_literal: true

module V1
  module Events
    # :nodoc:
    class Accesses < Grape::API
      format :json

      desc 'Update attendee access for check point'
      params do
        requires :event_id, type: Integer, desc: 'Event id.'
        requires :attendee_id, type: Integer, desc: 'Attendee id.'
        requires :check_point_id, type: Integer, desc: 'Check Point id.'
        requires :accept, type: Boolean, desc: 'Is accept this user.'
      end
      post '/v1/events/:event_id/accesses' do
        # TODO: Implement full features
        event = Event.find(params[:event_id])
        check_point = event.check_points.find(params[:check_point_id])
        if params[:accept]
          check_point.machine.beep
          check_point.latest_record(Attendee.find(params[:attendee_id])).increment
        else
          check_point.machine.beep('no')
        end
      end
    end
  end
end
