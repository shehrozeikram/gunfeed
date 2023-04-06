class AddBumpThisPostToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :bump_this_post, :boolean, default: false
  end
end
