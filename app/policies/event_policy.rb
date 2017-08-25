# frozen_string_literal: true
# missing top-level class documentation comment
class EventPolicy < ApplicationPolicy
  # missing top-level class documentation comment
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        user.events
      end
    end
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def edit?
    user.admin? || record.user_id == user.id
  end

  alias manage? edit?
end
