class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :title
      t.time :duration
      t.decimal :price
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
