# frozen_string_literal: true
# AttendeesController
class AttendeesController < ApplicationController
  before_action :find_attendee, only: [:edit, :destroy, :update]
  before_action :find_event, only: [:new, :edit]

  def index
    @attendees = Attendee.where(event_id: params[:event_id])
  end

  def new
    @attendee = Attendee.new
  end

  def destroy
    @attendee.destroy
    redirect_to event_attendees_path, notice: I18n.t('attendee.removed')
  end

  def create
    @attendee = Attendee.new(attendee_params)
    return redirect_to event_attendees_path, notice: I18n.t('attendee.created') if @attendee.save
    render :new
  end

  def edit() end

  def update
    return redirect_to event_attendees_path, notice: I18n.t('attendee.updated') if @attendee.update_attributes(attendee_params)
    render :edit
  end

  private

  def attendee_params
    params.require(:attendee).permit(:serial, :code, :name, :email, :phone, :card_serial, :event_id)
  end

  def find_attendee
    @attendee = Attendee.find_by(id: params[:id])
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
