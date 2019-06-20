# frozen_string_literal: true

# Create User Event Relationships
class ChangePermissionsToUserEventRelationships < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_event_relationships, :authority, :permissions
  end
end
