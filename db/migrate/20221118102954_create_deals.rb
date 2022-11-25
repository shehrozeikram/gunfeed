class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :title
      t.float :price
      t.string :store
      t.string :amount
      t.string :caliber
      t.string :category
      t.string :brand
      t.string :mpn
      t.float :upc
      t.string :body
      t.string :image
      t.string :video
      t.boolean :sponsored
      t.integer :category_id
      t.string :website_name

      t.timestamps
    end
  end
end
