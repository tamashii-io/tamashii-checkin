# frozen_string_literal: true

module Machines
  # Machine::ActionsController
  class ActionsController < ApplicationController
    include MachineConcern

    before_action :check_machine_permission!
    before_action -> { @machine = Machine.find(params[:machine_id]) }

    # TODO: should also hide buttons in views
    def create
      @machine.send(command) if @machine.respond_to?(command)
    end

    def command
      params.fetch(:command, nil).to_sym
    end
  end
end
