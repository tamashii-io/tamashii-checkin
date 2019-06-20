# frozen_string_literal: true

# missing top-level class documentation comment
class CheckPointsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
