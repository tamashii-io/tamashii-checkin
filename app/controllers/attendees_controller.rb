# frozen_string_literal: true
# AttendeesController
class AttendeesController < ApplicationController
  before_action :find_event
  before_action :find_attendee, only: [:edit, :destroy, :update]

  def index
    @attendees = @event.attendees

    respond_to do |format|
      format.html
      format.json { render json: @attendees }
    end
  end

  def new
    @attendee = @event.attendees.new
  end

  def destroy
    @attendee.destroy
    redirect_to event_attendees_path, notice: I18n.t('attendee.removed')
  end

  def create
    @attendee = @event.attendees.new(attendee_params)
    return redirect_to event_attendees_path, notice: I18n.t('attendee.created') if @attendee.save
    render :new
  end

  def edit; end

  def update
    return redirect_to event_attendees_path, notice: I18n.t('attendee.updated') if @attendee.update_attributes(attendee_params)
    render :edit
  end

  private

  def attendee_params
    params.require(:attendee).permit(:serial, :code, :name, :email, :phone, :card_serial)
  end

  def find_attendee
    @attendee = @event.attendees.find(params[:id])
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
