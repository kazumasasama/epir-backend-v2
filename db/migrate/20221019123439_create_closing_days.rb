class CreateClosingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :closing_days do |t|
      t.string :date
      t.string :start
      t.string :end
      t.string :title
      t.string :calendar_color
      t.string :content
      t.timestamps
    end
  end
end
