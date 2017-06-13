# frozen_string_literal: true
# Staffs Controller
class StaffsController < ApplicationController
  before_action :find_event
  before_action :find_staff, only: [:edit, :destroy]
  before_action :find_staff_for_update, only: :update

  after_action :verify_authorized, only: [:edit, :update, :destroy]
  after_action :verify_policy_scoped

  def index
    @staffs = @event.staffs
  end

  def new
    @relationship = @event.user_event_relationships.build(permissions: UserEventRelationship::DEFAULT_PERMISSIONS)
  end

  def create
    @relationship = @event.user_event_relationships.build(staff_params)
    return redirect_to event_staffs_path(@event) if @relationship.save
    render :new
  end

  def edit; end

  def update
    return redirect_to event_staffs_path(@event) if @staff.update_attributes(staff_params)
    render :edit
  end

  def destroy
    @staff.destroy
    redirect_to event_staffs_path(@event)
  end

  private

  def staff_params
    hash = params.require(:user_event_relationship).permit(:user_id, custom_fields: UserEventRelationship::DEFAULT_PERMISSIONS.keys).as_json
    hash['permissions'] = hash.delete 'custom_fields'
    hash
  end

  def find_event
    @event = policy_scope(Event).find(params[:event_id])
  end

  def find_staff
    @staff = @event.user_event_relationships.find_by(user_id: params[:id])
    authorize @staff, :editable?
  end

  def find_staff_for_update
    @staff = @event.user_event_relationships.find(params[:id])
    authorize @staff, :editable?
  end
end
