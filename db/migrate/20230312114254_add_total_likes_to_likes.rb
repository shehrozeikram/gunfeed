class AddTotalLikesToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :total_likes, :integer
  end
end
