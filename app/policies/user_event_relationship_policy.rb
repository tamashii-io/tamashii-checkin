# frozen_string_literal: true
# missing top-level class documentation comment
class UserEventRelationshipPolicy < ApplicationPolicy
  def editable?
    # record.user_id != record.event.user_id && (user.admin? || record.event.user_id = user.id)
    record.user_id != record.event.user_id && (user.admin? || record.event.user_id = user.id)
  end

  def read_check_point?
    user.admin? || record.event.user_id = user.id || record.permissions['read_check_point'] == '1'
  end

  def write_check_point?
    record.permissions['write_check_point'] == '1'
  end
end
