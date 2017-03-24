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
    @event.destroy if @event
    redirect_to events_path, notice: '活動已刪除!'
  end

  def create
  @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: '新增活動成功'
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to events_path, notice: '資料更新成功!'
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at)
  end

  def find_event
    @event = Event.find_by(id: params[:id])
  end
end
