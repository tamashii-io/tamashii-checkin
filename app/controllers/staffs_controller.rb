# frozen_string_literal: true
# Staffs Controller
class StaffsController < ApplicationController
  before_action :find_event
  before_action :find_staff, only: [:show, :edit, :update, :destroy]

  def index
    @staffs = @event.staffs
  end

  def show; end

  def new
    @relationship = @event.user_event_relationships.build
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
    params.require(:user_event_relationship).permit(:user_id, :role)
  end

  def find_event
    @event = current_user.events.find(params[:event_id])
  end

  def find_staff
    @staff = @event.user_event_relationships.find_by(user_id: params[:id])
  end
end
