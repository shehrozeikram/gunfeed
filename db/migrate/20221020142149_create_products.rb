class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_url
      t.string :title
      t.integer :price
      t.string :store
      t.integer :amount
      t.string :category
      t.string :caliber
      t.string :brand
      t.string :mpn
      t.string :upc
      t.string :body
      t.string :image

      t.timestamps
    end
  end
end
