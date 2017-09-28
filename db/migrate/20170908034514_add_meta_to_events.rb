class AddMetaToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :meta, :jsonb
  end
end
