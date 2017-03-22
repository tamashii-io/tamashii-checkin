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
    redirect_to events_path, notice: "活動已刪除!"
  end

  def create
	@event = Event.new(event_params)
    if @event.save
      # 成功
      redirect_to events_path, notice: "新增活動成功!"
    else
      # 失敗
      render :new
    end
  end
  
  def edit
  end

  def update
    if @event.update_attributes(event_params)
      # 成功
      redirect_to events_path, notice: "資料更新成功!"
    else
      # 失敗
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
