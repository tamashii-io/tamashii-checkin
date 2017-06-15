# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointPolicy < ApplicationPolicy
  # missing top-level class documentation comment
  class Scope < Scope
    include Pundit
    def resolve
      if user.admin? || event_owner? || write_check_point?
        scope
      else
        scope.where(registrar_id: user.id)
      end
    end

    private

    def event_owner?
      scope.first.event.user_id == user.id
    end

    def write_check_point?
      relationship = UserEventRelationship.find_by(event_id: scope.first.event.id, user_id: user.id)
      UserEventRelationshipPolicy.new(user, relationship).write_check_point?
    end
  end

  def editable?
    user.admin? || record.event.user_id == user.id || policy(find_relationship).write_check_point?
  end

  private

  def find_relationship(event = record.event)
    UserEventRelationship.find_by(event_id: event.id, user_id: user.id)
  end
end
