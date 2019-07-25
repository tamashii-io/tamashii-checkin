# frozen_string_literal: true

class AddCategoryToCheckPoints < ActiveRecord::Migration[5.2]
  def change
    change_table :check_points, bulk: true do |t|
      t.string :category
      t.index %i[event_id category]
    end
  end
end
