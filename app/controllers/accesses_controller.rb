# frozen_string_literal: true

# :nodoc:
class AccessesController < ApplicationController
  before_action -> { @event = current_user.events.find(params[:event_id]) }
  before_action -> { @check_point = @event.check_points.gate.find_by(registrar: current_user) }

  def index
    # TODO: Reject user didn't have Gate checkpoint
    @records = @check_point.check_records
    
    respond_to do |format|
      format.html
      format.json { render json: @records }
    end
  end
end
