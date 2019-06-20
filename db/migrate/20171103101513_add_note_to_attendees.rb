# frozen_string_literal: true

class AddNoteToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :note, :text, default: ''
  end
end
