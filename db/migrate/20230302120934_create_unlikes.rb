class CreateUnlikes < ActiveRecord::Migration[7.0]
  def change
    create_table :unlikes do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
