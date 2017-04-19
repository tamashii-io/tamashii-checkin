# frozen_string_literal: true
# Machine Serializer
class MachineSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :serial, :name

  attribute :links do
    {
      edit: edit_machine_path(object),
      self: machine_path(object)
    }
  end
end
