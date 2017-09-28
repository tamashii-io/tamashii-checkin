class AddCodeEventIndexToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_index :attendees, [:event_id, :code], unique: true
  end
end
