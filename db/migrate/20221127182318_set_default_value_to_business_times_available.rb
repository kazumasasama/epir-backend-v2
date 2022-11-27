class SetDefaultValueToBusinessTimesAvailable < ActiveRecord::Migration[7.0]
  def change
    remove_column :business_times, :available, :boolean
    add_column :business_times, :available, :boolean, default: true
  end
end
