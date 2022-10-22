class AddLineIdToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :line_id, :string
  end
end
