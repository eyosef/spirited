class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :zipcode
      t.string :phone_number
      t.boolean :bilingual
      t.boolean :tasting_bar
      t.boolean :public_transport
      t.string :hours_of_operation

      t.timestamps
    end
  end
end
