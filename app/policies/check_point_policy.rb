# frozen_string_literal: true

# missing top-level class documentation comment
class CheckPointPolicy < ApplicationPolicy
  include Pundit
  # Policy is incorrect should be fixed and discuss
  class Scope < Scope
    include Pundit
    def resolve
      if scope.empty?
        scope
      elsif user.admin? || event_owner? || read_check_point?
        scope
      else
        scope.where(registrar_id: user.id)
      end
    end

    private

    # TODO: Refactor this
    def read_check_point?
      EventPolicy.new(user, scope.first.event).read_check_point?
    end

    def event_owner?
      scope.first.event.user_id == user.id
    end
  end

  def edit?
    user.admin? || event_owner? || write_check_point? || record.registrar_id == user.id
  end

  alias update? edit?

  def manage?
    user.admin? || event_owner? || write_check_point?
  end

  alias destroy? manage?
  alias create? manage?

  def permitted_attributes_for_update
    if manage?
      %i[name type category machine_id registrar_id]
    else
      %i[name type category machine_id]
    end
  end

  private

  def event_owner?
    record.event.user_id == user.id
  end

  # TODO: Refactor this
  def write_check_point?
    EventPolicy.new(user, record.event).write_check_point?
  end
end
