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

  # TODO: Rewrite this to check by user
  def staff_owned_gate?
    record.check_points.where(registrar: user).map(&:gate?).reduce(:|)
  end

  def read_check_point?
    user.admin? || owner? || permissions.read_check_point?
  end

  def write_check_point?
    user.admin? || owner? || permissions.write_check_point?
  end

  def read_attendee?
    user.admin? || owner? || permissions.read_attendee?
  end

  def write_attendee?
    user.admin? || owner? || permissions.write_attendee?
  end

  def manage?
    user.admin? || owner?
  end

  alias edit? manage?
  alias destroy? manage?

  def owner?
    record.user_id == user.id
  end

  protected

  def permissions
    record.user_event_relationships.find_by(user: user)
  end
end
