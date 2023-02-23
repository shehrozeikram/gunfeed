class CreateRebates < ActiveRecord::Migration[7.0]
  def change
    create_table :rebates do |t|
      t.string :body
      t.integer :product_id

      t.timestamps
    end
  end
end
