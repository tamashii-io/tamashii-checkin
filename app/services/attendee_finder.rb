# frozen_string_literal: true

class AttendeeFinder
  def initialize(event, category)
    @event = event
    @category = category
  end

  def perform
    @event
      .check_records
      .includes(:attendee)
      .where(check_point: points_by_category, times: 1..Float::INFINITY)
      .map(&:attendee)
  end

  private

  def points_by_category
    @points_by_category ||=
      @event.check_points.where(category: @category)
  end
end
