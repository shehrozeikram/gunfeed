class AddVerifiedToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :verified, :string
  end
end
