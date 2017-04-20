# frozen_string_literal: true
# missing top-level class documentation comment
class CheckrecordsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'checkrecords_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
