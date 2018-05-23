class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :product_id
      t.string :product_review
      t.integer :user_id

      t.timestamps
    end
  end
end
