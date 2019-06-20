# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class Attendees < Grape::API
      resources :attendees do
        desc 'Get attendees summary'
        get '/summary' do
          attendees = Event.find(params[:event_id]).attendees
          {
            attendees: attendees.count,
            checkin: attendees.checked_in.count
          }
        end
        desc 'Attendees List'
        get '/' do
          Event.find(params[:event_id]).attendees.as_json(only: %i[id serial code name email phone note checked_in])
        end
      end
    end
  end
end
