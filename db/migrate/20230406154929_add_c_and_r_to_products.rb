class AddCAndRToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :c_and_r, :boolean
  end
end
