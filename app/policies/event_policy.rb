# frozen_string_literal: true
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
end
