# frozen_string_literal: true
class AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if EventPolicy.new(user, scope.first.event).read_attendee?
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
