# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointsController < ApplicationController
  before_action :find_event, except: [:show]
  before_action :find_checkpoint, only: [:edit, :update, :destroy]
  def index
    @checkpoints = @event.check_points
  end

  def new
    @checkpoint = @event.check_points.build
  end

  def create
    @checkpoint = @event.check_points.build(checkpoint_params)
    return redirect_to event_check_points_path, notice: I18n.t('checkPoint.created') if @checkpoint.save
    render :new
  end

  def edit; end

  def update
    return redirect_to event_check_points_path, notice: I18n.t('checkPoint.updated') if @checkpoint.update_attributes(checkpoint_params)
    render :edit
  end

  def destroy
    @checkpoint.destroy
    redirect_to event_check_points_path, notice: I18n.t('checkPoint.removed')
  end

  private

  def checkpoint_params
    params.require(:check_point).permit(:name, :type, :machine_id, :registrar_id)
  end

  def find_checkpoint
    @checkpoint = @event.check_points.find(params[:id])
  end

  def find_event
    @event = current_user.events.find(params[:event_id])
  end
end
