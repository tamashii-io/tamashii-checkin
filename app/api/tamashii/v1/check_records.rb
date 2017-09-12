# frozen_string_literal: true

module Tamashii
  module V1
    # :nodoc:
    class CheckRecords < Grape::API
      resources :check_records do
        desc 'Update attendee access for check records'
        get '/' do
          event = Event.find(params[:event_id])
          check_records = event.check_records.as_json(only: [:attendee_id, :check_point_id, :times, :created_at, :updated_at])
          check_records.each {|check_record| check_record["count"] = check_record.delete "times" }
        end
      end
    end
  end
end
