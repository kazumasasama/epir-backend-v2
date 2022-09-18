class AddCategoryIdToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :category_id, :integer
  end
end
