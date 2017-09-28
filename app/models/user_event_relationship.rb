# frozen_string_literal: true
# User Event Relationship
class UserEventRelationship < ApplicationRecord
  DEFAULT_PERMISSIONS = {
    read_check_point: false,
    write_check_point: false,
    write_attendee: false,
    read_attendee: false
  }.freeze

  before_create { self.permissions = DEFAULT_PERMISSIONS.merge(permissions || {}) }
  before_save :cast_permissions

  belongs_to :user
  belongs_to :event

  # TODO: Mapping permissions
  def read_attendee?
    permissions['read_attendee']
  end

  def write_attendee?
    permissions['write_attendee']
  end

  def read_check_point?
    permissions['read_check_point']
  end

  def write_check_point?
    permissions['write_check_point']
  end

  private

  def cast_permissions
    new_permissions = permissions.map do |key, value|
      [key, ActiveModel::Type::Boolean.new.cast(value)]
    end
    self.permissions = Hash[new_permissions]
  end
end
