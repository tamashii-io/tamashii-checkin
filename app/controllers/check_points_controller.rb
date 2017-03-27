# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPointsController < ApplicationController
  before_action :find_checkpoint, only: [:edit, :update, :destroy]
  def index
    @checkpoints = CheckPoint.all
  end

  def new
    @checkpoint = CheckPoint.new
  end

  def create
    @checkpoint = CheckPoint.new(checkpoint_params)
    return redirect_to check_points_path, notice: I18n.t('checkPoint.created') if @checkpoint.save
    render :new
  end

  def edit; end

  def update
    return redirect_to check_points_path, notice: I18n.t('checkPoint.updated') if @checkpoint.update_attributes(checkpoint_params)
    render :edit
  end

  def destroy
    @checkpoint&.destroy if @checkpoint
    redirect_to check_points_path, notice: I18n.t('checkPoint.removed')
  end

  private

  def checkpoint_params
    params.require(:check_point).permit(:name, :type, :machine_id, :event_id)
  end

  def find_checkpoint
    @checkpoint = CheckPoint.find_by(id: params[:id])
  end
end
