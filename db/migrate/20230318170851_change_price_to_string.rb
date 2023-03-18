class ChangePriceToString < ActiveRecord::Migration[7.0]
  def self.up
    change_column :products, :price, 'string'
  end

  def self.down
    change_column :products, :price, 'float'
  end

end
