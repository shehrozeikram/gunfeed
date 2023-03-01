class AddIsPopularToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :is_popular, :boolean
  end
end
