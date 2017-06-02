# frozen_string_literal: true

# :nodoc:
class CheckRecordsController < ApplicationController
  before_action :find_event
  def index
    @checkrecords = @event.check_records

    respond_to do |format|
      format.html
      format.json { render json: @checkrecords }
    end
  end

  private

  def find_event
    @event = current_user.events.find(params[:event_id])
  end
end
