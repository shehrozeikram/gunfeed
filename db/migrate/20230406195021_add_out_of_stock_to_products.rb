class AddOutOfStockToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :out_of_stock, :boolean
  end
end
