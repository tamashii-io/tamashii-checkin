class CheckpointsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    strean_from 'checkpoint_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
