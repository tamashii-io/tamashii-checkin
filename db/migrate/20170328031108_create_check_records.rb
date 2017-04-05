# frozen_string_literal: true
# missing top-level class documentation comment
class CreateCheckRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :check_records do |t|
      t.string :attendee_id
      t.string :checkpoint_id
      t.integer :times

      t.timestamps
    end
  end
end
