# frozen_string_literal: true
module V1
  module Events
    # missing top-level class documentation comment
    class Attendees < Grape::API
      format :json

      desc 'get attendees summary'

      params do
        requires :id, type: String, desc: 'event id'
      end

      get '/v1/events/:id/attendees/summary' do
        attendees = Event.find_by(id: params[:id]).attendees
        { attendees: attendees.count, checkin: attendees.not_checked_in }
      end
    end
  end
end
