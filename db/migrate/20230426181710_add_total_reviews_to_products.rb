class AddTotalReviewsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :total_reviews, :integer
  end
end
