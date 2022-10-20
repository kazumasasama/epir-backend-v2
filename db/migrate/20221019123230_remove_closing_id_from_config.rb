class RemoveClosingIdFromConfig < ActiveRecord::Migration[7.0]
  def change
    remove_column :configs, :closing_id, :integer
  end
end
