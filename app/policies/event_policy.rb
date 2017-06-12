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
    user.admin?
  end

  def edit?
    user.admin? || record.user_id == user.id
  end

  def admin_or_event_manager?
    user.admin? || record.user_id == user.id
  end
end
