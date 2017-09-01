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

#TODO: It should be has_gate_for? because rubocop error. Plesee fix it in the future.
  def gate_for?(user)
    check_point = record.check_points.find_by(registrar_id: user.id)
    return false if check_point.nil?
    check_point.type == "gate"
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def edit?
    user.admin? || record.user_id == user.id
  end

  alias manage? edit?
end
