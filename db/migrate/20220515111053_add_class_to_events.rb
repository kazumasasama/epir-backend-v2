class AddClassToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :class, :string
  end
end
