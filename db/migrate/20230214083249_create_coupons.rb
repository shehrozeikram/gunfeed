class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.float :discount
      t.string :coupon_code
      t.date :start_date
      t.date :expiration_date
      t.integer :store_id
      t.boolean :unknown_expiration

      t.timestamps
    end
  end
end
