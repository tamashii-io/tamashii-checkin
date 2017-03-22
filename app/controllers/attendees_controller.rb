class AttendeesController < ApplicationController
	before_action :find_event, only: [:new, :create, :edit]	
	before_action :find_attendee, only: [:edit, :update, :destroy]

	def index
		@attendees = Attendee.where(event_id: params[:event_id])
	end

	def new	
		@attendee = Attendee.new
	end

	def create
		@attendee = Attendee.new(attendee_params)

		@event.attendees << @attendee

		if @attendee.save
		  # 成功
		  redirect_to event_attendees_path, notice: "新增活動成功!"
		else
		  # 失敗
		  render :new
		end
	end

	def edit
	end

	def update

		if @attendee.update_attributes(attendee_params)
		  # 成功
		  redirect_to event_attendees_path, notice: "資料更新成功!"
		else
		  # 失敗
		  render :edit
		end
	end

	def destroy
		@attendee.destroy if @attendee
		redirect_to event_attendees_path, notice: "活動資料已刪除!"
	end


	private
	def attendee_params
		params.require(:attendee).permit(:name, :email, :phone, :meta)
	end

	def find_attendee
		@attendee = Attendee.find_by(id: params[:id])
	end

	def find_event
		@event = Event.find_by(id: params[:event_id])
	end
end
