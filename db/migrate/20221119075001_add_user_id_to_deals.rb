class AddUserIdToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :user_id, :integer
  end
end
