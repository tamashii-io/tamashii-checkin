# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointPolicy < ApplicationPolicy
  include Pundit
  # Policy is incorrect should be fixed and discuss
  class Scope < Scope
    include Pundit
    def resolve
      if user.admin? || event_owner?
        scope
      else
        scope.where(registrar_id: user.id)
      end
    end

    private

    def event_owner?
      scope.first.event.user_id == user.id
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

  # TODO: Refactor this
  def write_check_point?
    EventPolicy.new(user, record.event).write_check_point?
  end
end
