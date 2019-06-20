# frozen_string_literal: true

# Add Registrar To Check Points
class AddRegistrarToCheckPoints < ActiveRecord::Migration[5.1]
  def change
    add_reference :check_points, :registrar
  end
end
