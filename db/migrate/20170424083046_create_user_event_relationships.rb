# frozen_string_literal: true
# Create User Event Relationships
class CreateUserEventRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :user_event_relationships do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
