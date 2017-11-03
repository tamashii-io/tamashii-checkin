# frozen_string_literal: true

class AttendeesController < ApplicationController
  before_action :find_event
  before_action :find_attendee, only: [:edit, :destroy, :update]
  before_action :verify_writable, only: [:new, :create, :sync]

  after_action :verify_authorized, only: [:edit, :update, :destroy, :unbind]

  def index
    @attendees = policy_scope(@event.attendees)

    respond_to do |format|
      format.html
      format.json { render json: @attendees }
    end
  end

  def new
    @attendee = @event.attendees.new
    authorize @attendee
  end

  def destroy
    @attendee.destroy
    redirect_to event_attendees_path, notice: I18n.t('attendee.removed')
  end

  def create
    @attendee = @event.attendees.new(attendee_params)
    authorize @attendee
    return redirect_to event_attendees_path, notice: I18n.t('attendee.created') if @attendee.save
    render :new
  end

  def edit; end

  def update
    return redirect_to event_attendees_path, notice: I18n.t('attendee.updated') if @attendee.update_attributes(attendee_params)
    render :edit
  end

  # TODO: Use ajax to load this page
  def unbind
    @attendee = @event.attendees.find(params[:attendee_id])
    authorize @attendee
    render json: @attendee.update(card_serial: '')
  end

  # TODO: Support all third-party system
  def sync
    @event.sync_pansci_attendees
    redirect_to event_attendees_path, notice: I18n.t('attendee.synced')
  end

  private

  def attendee_params
    params.require(:attendee).permit(:serial, :code, :name, :email, :phone, :note, :card_serial)
  end

  def find_attendee
    @attendee = @event.attendees.find(params[:id])
    authorize @attendee
  end

  def find_event
    @event = current_user.events.find(params[:event_id])
  end

  def verify_writable
    return if policy(@event).write_attendee?
    deny_access
  end
end
