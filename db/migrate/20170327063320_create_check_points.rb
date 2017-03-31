# frozen_string_literal: true
# missing top-level class documentation comment
class CreateCheckPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :check_points do |t|
      t.string :name
      t.integer :type
      t.string :machine_id
      t.string :event_id

      t.timestamps
    end
  end
end
