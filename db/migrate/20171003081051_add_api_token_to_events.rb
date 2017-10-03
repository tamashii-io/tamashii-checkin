class AddApiTokenToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :api_token, :string
  end
end
