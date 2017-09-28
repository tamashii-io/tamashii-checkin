# frozen_string_literal: true
# Staffs Controller
class StaffsController < ApplicationController
  before_action :find_event
  before_action :find_staff, only: [:edit, :destroy]
  before_action :find_staff_for_update, only: :update

  after_action :verify_authorized, only: [:edit, :update, :destroy]
  after_action :verify_policy_scoped

  def index
    @relationships = @event.user_event_relationships.includes(:user)
  end

  def new
    @relationship = @event.user_event_relationships.build(permissions: UserEventRelationship::DEFAULT_PERMISSIONS)
  end

  # rubocop:disable Lint/AssignmentInCondition
  def create
    if staff_params_after_transform = transform_user_id(staff_params)
      @relationship = @event.user_event_relationships.build(staff_params_after_transform)
      return redirect_to event_staffs_path(@event) if @relationship.save
    else
      @relationship = @event.user_event_relationships.build(permissions: UserEventRelationship::DEFAULT_PERMISSIONS)
      @relationship.errors.add(:user, "無法建立新的使用者。所提供的email已存在或者格式錯誤: #{staff_params['user_id']}")
    end
    render :new
  end
  # rubocop:enable Lint/AssignmentInCondition

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

  def create_new_staff(email)
    password = Devise.friendly_token.first(8)
    new_user = User.create!(email: email, password: password, admin: false)
    UserMailer.notify_new_staff(@event, current_user, new_user, password).deliver_later
    new_user
  end

  def transform_user_id(params)
    unless User.exists?(params['user_id'])
      email_field = params['user_id']
      params[:user_id] = create_new_staff(email_field).id
    end
    params
  rescue
    nil
  end

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
