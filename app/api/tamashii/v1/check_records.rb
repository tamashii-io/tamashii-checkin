# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class CheckRecords < Grape::API
      resources :check_records do
        desc 'Update attendee access for check records'
        get '/' do
          event = Event.find(params[:event_id])
          event.check_records.as_json(only: %i[attendee_id check_point_id times created_at updated_at])
        end
      end
    end
  end
end
