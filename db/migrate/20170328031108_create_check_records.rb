# frozen_string_literal: true

# missing top-level class documentation comment
class CreateCheckRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :check_records do |t|
      t.integer :attendee_id
      t.integer :check_point_id
      t.integer :times

      t.timestamps
    end
  end
end
