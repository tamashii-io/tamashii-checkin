# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointPolicy < ApplicationPolicy
  include Pundit
  # missing top-level class documentation comment
  class Scope < Scope
    include Pundit
    def resolve
      if scope.empty?
        scope
      elsif user.admin? || event_owner? || write_check_point?
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

  def edit?
    user.admin? || record.event.user_id == user.id || write_check_point? || record.registrar_id == user.id
  end

  alias update? edit?

  def manage?
    user.admin? || record.event.user_id == user.id || write_check_point?
  end

  alias destroy? manage?

  def permitted_attributes_for_update
    if manage?
      [:name, :type, :machine_id, :registrar_id]
    else
      [:name, :type, :machine_id]
    end
  end

  private

  def write_check_point?
    relationship = UserEventRelationship.find_by(event_id: record.event.id, user_id: user.id)
    UserEventRelationshipPolicy.new(user, relationship).write_check_point?
  end
end
