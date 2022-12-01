class ChangePriceToFloat < ActiveRecord::Migration[7.0]
  def self.up
    change_column :products, :price, 'float'
  end

  def self.down
    change_column :products, :price, 'integer',  default: 0
  end
end
