# frozen_string_literal: true

# Create User Event Relationships
class AddAdminToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :user_id, :integer
  end
end
