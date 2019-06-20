# frozen_string_literal: true

# Machines Channel
class MachinesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'machines'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
