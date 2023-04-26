class AddTotalUnlikesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :total_unlikes, :integer
  end
end
