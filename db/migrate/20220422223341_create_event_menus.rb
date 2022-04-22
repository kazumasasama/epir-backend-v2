class CreateEventMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :event_menus do |t|
      t.integer :event_id
      t.integer :menu_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
