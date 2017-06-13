# frozen_string_literal: true
# User Event Relationship
class UserEventRelationship < ApplicationRecord
  DEFAULT_PERMISSIONS = {
    write_check_point: false,
    write_attendee: false,
    read_check_point: false,
    read_attendee: false
  }.freeze
  before_create { self.permissions = DEFAULT_PERMISSIONS.merge(permissions || {}) }

  belongs_to :user
  belongs_to :event
end
