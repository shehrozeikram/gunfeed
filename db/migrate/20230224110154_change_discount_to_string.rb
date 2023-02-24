class ChangeDiscountToString < ActiveRecord::Migration[7.0]
  def self.up
    change_column :coupons, :discount, 'string'
  end

  def self.down
    change_column :coupons, :discount, 'float'
  end
end
