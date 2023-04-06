class AddDealTypeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :deal_type, :string
  end
end
