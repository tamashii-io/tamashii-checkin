# frozen_string_literal: true
# EventsController
class EventsController < ApplicationController
  before_action :find_event, only: [:edit, :update, :destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def destroy
    @event&.destroy if @event
    redirect_to events_path, notice: I18n.t('event.removed')
  end

  def create
    @event = Event.new(event_params)
    return redirect_to events_path, notice: I18n.t('event.created') if @event.save
    render :new
  end

  def edit() end

  def update
    return redirect_to events_path, notice: I18n.t('event.updated') if @event.update_attributes(event_params)
    render :edit
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end

  def find_event
    @event = Event.find_by(id: params[:id])
  end
end
