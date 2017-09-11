# frozen_string_literal: true
# missing top-level class documentation comment
class UserEventRelationshipPolicy < ApplicationPolicy
  def editable?
    user.admin? || record.event.user_id == user.id || record.permission.write_attendee?
  end

  def read_check_point?
    user.admin? || record.event.user_id = user.id || record.permissions['read_check_point'] == '1'
  end

  def write_check_point?
    record.permissions['write_check_point'] == '1'
  end
end
