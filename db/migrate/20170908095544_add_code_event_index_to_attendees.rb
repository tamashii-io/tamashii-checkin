# frozen_string_literal: true

class AddCodeEventIndexToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_index :attendees, %i[event_id code], unique: true
  end
end
