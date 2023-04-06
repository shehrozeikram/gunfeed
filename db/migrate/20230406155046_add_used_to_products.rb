class AddUsedToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :used, :boolean
  end
end
