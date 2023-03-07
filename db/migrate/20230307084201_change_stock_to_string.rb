class ChangeStockToString < ActiveRecord::Migration[7.0]
  def self.up
    change_column :products, :stock, 'string'
  end

  def self.down
    change_column :products, :stock, 'integer'
  end

end
