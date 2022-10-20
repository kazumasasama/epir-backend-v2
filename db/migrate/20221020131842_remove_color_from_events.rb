class RemoveColorFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :color, :string
  end
end
