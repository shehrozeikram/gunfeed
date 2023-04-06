class AddRevolverToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :revolver, :boolean, default: false
  end
end
