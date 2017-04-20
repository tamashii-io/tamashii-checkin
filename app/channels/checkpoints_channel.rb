# frozen_string_literal: true
# missing top-level class documentation comment
class CheckpointsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'checkpoint_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
