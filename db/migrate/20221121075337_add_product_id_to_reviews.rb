class AddProductIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :product_id, :integer
  end
end
