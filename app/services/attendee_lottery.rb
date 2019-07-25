# frozen_string_literal: true

class AttendeeLottery
  def initialize(event, category:)
    @event = event
    @category = category
  end

  def perform
    attendees
      .sample
      &.slice(:serial, :name)
  end

  alias draw perform

  private

  def attendees
    AttendeeFinder.new(@event, @category).perform
  end
end
