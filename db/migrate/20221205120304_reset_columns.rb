class ResetColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :store
    remove_column :products, :category
    add_reference(:products, :store, foreign_key: true)
  end
end
