class CreateConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :configs do |t|
      t.string :lang
      t.decimal :tax
      t.integer :closing_id
      t.decimal :start
      t.decimal :end
      t.integer :interval

      t.timestamps
    end
  end
end
