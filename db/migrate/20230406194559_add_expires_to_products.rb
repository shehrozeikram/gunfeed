class AddExpiresToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :expires, :boolean, default: false
  end
end
