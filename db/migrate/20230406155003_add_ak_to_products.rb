class AddAkToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :ak, :boolean, default: false
  end
end
