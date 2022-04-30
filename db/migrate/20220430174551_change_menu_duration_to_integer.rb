class ChangeMenuDurationToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :menus, :duration, :time
    add_column :menus, :duration, :integer
  end
end
