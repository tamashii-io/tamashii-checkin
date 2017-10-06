# frozen_string_literal: true
class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    # TODO: refactor this policy, seems a little weird
    def resolve
      first_attendee = scope.first
      if first_attendee && EventPolicy.new(user, first_attendee.event).read_attendee?
        scope.all
      else
        []
      end
    end
  end

  def manage?
    EventPolicy.new(user, @record.event).write_attendee?
  end

  alias new? manage?
  alias create? manage?
  alias edit? manage?
  alias update? manage?
  alias destroy? manage?
  alias unbind? manage?
end
