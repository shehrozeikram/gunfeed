class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.string :image
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
