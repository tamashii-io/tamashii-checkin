# frozen_string_literal: true
# missing top-level class documentation comment
class MachinesController < ApplicationController
  before_action :find_machine, only: [:edit, :update, :destroy]

  def index
    @machines = Machine.all
    @machine_activities = Tamashii::Machine.activities
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)

    return redirect_to machines_path, notice: I18n.t('machine.created') if @machine.save
    render :new
  end

  def edit; end

  def update
    return redirect_to machines_path, notice: I18n.t('machine.updated') if @machine.update_attributes(machine_params)
    render :edit
  end

  def destroy
    @machine.destroy
    redirect_to machines_path, notice: I18n.t('machine.removed')
  end

  private

  def machine_params
    params.require(:machine).permit(:serial, :name)
  end

  def find_machine
    @machine = Machine.find_by(id: params[:id])
  end
end
