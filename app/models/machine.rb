# frozen_string_literal: true
# Missing top-level class documentation comment.
class Machine < ApplicationRecord
  has_many :check_points
  has_many :events, through: :check_points
  def current_event_check_point
    check_points.find_by(event: events.now)
  end
end
