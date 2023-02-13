class AddProductIdToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :product_id, :integer
  end
end
