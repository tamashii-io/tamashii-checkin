# frozen_string_literal: true

# missing top-level class documentation comment
class CreateCheckPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :check_points do |t|
      t.string :name
      t.integer :type
      t.integer :machine_id
      t.integer :event_id

      t.timestamps
    end
  end
end
