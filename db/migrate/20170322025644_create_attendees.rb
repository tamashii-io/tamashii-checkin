# frozen_string_literal: true
class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.integer :serial
      t.string :code
      t.string :name
      t.string :email
      t.string :phone
      t.string :card_serial
      t.integer :event_id

      t.timestamps
    end
  end
end
