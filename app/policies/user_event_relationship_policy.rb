# frozen_string_literal: true
# missing top-level class documentation comment
class UserEventRelationshipPolicy < ApplicationPolicy
  def owner?
    record.event.user_id == user.id
  end

  alias editable? owner?
end
