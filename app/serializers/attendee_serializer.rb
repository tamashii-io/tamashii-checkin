# frozen_string_literal: true
# Attendee Serializer
class AttendeeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :serial, :code, :name, :email, :phone, :card_serial

  attribute :links do
    {
      edit: edit_event_attendee_path(object.event, object),
      self: event_attendee_path(object.event, object)
    }
  end
end
