# frozen_string_literal: true
# EventsController
class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
  end

  def show; end

  def new
    @event = Event.new
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: I18n.t('event.removed')
  end

  def create
    @event = Event.new(event_params)
    # TODO: Let admin can manage all events and add new staff
    @event.staffs << current_user
    @event.user_event_relationships.first.role = 0
    return redirect_to events_path, notice: I18n.t('event.created') if @event.save
    render :new
  end

  def edit(); end

  def update
    return redirect_to events_path, notice: I18n.t('event.updated') if @event.update_attributes(event_params)
    render :edit
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end

  def find_event
    @event = current_user.events.find_by(id: params[:id])
  end
end
