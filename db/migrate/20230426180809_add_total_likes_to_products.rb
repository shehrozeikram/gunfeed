class AddTotalLikesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :total_likes, :integer
  end
end
