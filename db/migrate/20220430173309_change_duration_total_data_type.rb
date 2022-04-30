class ChangeDurationTotalDataType < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :duration_total, :time
    add_column :events, :duration_total, :integer
  end
end
