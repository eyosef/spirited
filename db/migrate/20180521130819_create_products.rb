class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :variety
      t.string :style
      t.integer :alcohol_content
      t.integer :price_in_cents
      t.string :producer_name
      t.string :serving_suggestion
      t.string :flavor_profile
      t.string :image
      t.integer :producer_id
      t.integer :store_id

      t.timestamps
    end
  end
end
