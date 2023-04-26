class AddTotalRebatesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :total_rebates, :integer
  end
end
