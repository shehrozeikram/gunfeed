class AddUserUnlikeToUnlikes < ActiveRecord::Migration[7.0]
  def change
    add_column :unlikes, :user_unlike, :integer, default: 0
  end
end
