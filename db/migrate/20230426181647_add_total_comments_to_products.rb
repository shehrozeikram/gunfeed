class AddTotalCommentsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :total_comments, :integer
  end
end
