# frozen_string_literal: true
module AttendeesApi
  module V1
    # missing top-level class documentation comment
    class Summary < Grape::API
      format :json

      desc 'get attendees summary'

      params do
        requires :event_id, type: String, desc: 'event id'
      end

      get '/' do
        attendees = Event.find_by(id: params[:event_id]).attendees
        { attendees: attendees.count, checkin: attendees.where.not(card_serial: '').count }
      end
    end
  end
end
