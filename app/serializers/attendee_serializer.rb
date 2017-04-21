# frozen_string_literal: true
# Attendee Serialer
class AttendeeSerializer < ActiveModel::Serializer
  attributes :serial, :code, :name, :email, :phone, :card_serial
end
