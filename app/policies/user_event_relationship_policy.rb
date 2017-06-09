# frozen_string_literal: true
# missing top-level class documentation comment
class UserEventRelationshipPolicy < ApplicationPolicy
  def editable?
    user.admin? || record.user_id = user.id
  end
end
