class AddCalendarColorToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :calendar_color, :string
  end
end
