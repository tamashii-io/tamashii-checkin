# frozen_string_literal: true
# Add Default to Check Record Times
class AddDefaultValueToCheckRecordTimes < ActiveRecord::Migration[5.1]
  def change
    change_column :check_records, :times, :integer, default: 0
  end
end
