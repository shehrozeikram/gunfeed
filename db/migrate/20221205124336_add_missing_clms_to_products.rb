class AddMissingClmsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :shipping_cost, :string
    add_column :products, :shipping_weight, :string
    add_column :products, :description, :text
    add_column :products, :link, :string
    add_column :products, :image_link, :text
    add_column :products, :condition, :string
  end
end
