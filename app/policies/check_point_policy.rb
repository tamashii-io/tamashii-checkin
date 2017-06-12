# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointPolicy < ApplicationPolicy
  def editable?
    user.admin? || record.event.user_id == user.id
  end
end
