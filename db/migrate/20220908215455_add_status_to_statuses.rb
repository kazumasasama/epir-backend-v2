class AddStatusToStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :statuses, :status, :boolean, default: true
  end
end
