# frozen_string_literal: true
# Create User Event Relationships
class SetPermissionsDefaultToUserEventRelationships < ActiveRecord::Migration[5.1]
  def up
    change_column_default :user_event_relationships, :permissions, {}
  end
end
