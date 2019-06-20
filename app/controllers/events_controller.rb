# frozen_string_literal: true

# EventsController
class EventsController < ApplicationController
  before_action :find_event, only: %i[edit destroy]

  after_action :verify_authorized, only: %i[edit update destroy]
  after_action :verify_policy_scoped, only: %i[index show]

  def index
    @events = policy_scope(Event)
  end

  def show
    @event = policy_scope(Event).find(params[:id])
  end

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
    # TODO: modified @event.user = current_user
    @event.user_id = current_user.id
    @event.staffs << current_user
    return redirect_to events_path, notice: I18n.t('event.created') if @event.save

    render :new
  end

  def edit(); end

  def update
    @event = Event.find(params[:id])
    authorize @event, :edit?
    return redirect_to events_path, notice: I18n.t('event.updated') if @event.update(event_params)

    render :edit
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at, :pansci_event, :pansci_event_id, :pansci_event_secret)
  end

  def find_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
