class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :state
      t.string :city
      t.string :address
      t.string :zip
      t.string :url
      t.string :insta
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
