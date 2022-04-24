class RemoveEventIdFromBusinessTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :business_times, :event_id, :integer
  end
end
