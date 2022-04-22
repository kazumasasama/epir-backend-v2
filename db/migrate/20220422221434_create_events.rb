class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :date
      t.time :start
      t.time :end
      t.integer :user_id
      t.time :duration_total

      t.timestamps
    end
  end
end
