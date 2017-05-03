# frozen_string_literal: true
# Attendee Serializer
class CheckRecordSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :attendee_id, :check_point_id, :times, :created_at, :updated_at
  attribute :check_point do
    {
      name: object.check_point.name
    }
  end
  attribute :attendee do
    {
      name: object.attendee.name
    }
  end
end

