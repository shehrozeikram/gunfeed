class AddArToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :ar, :boolean, default: false
  end
end
