class AddSponsoredToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :sponsored, :boolean
  end
end
