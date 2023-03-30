class AddUserLikeToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :user_like, :integer, default: 0
  end
end
