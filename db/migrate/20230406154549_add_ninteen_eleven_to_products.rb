class AddNinteenElevenToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :ninteen_eleven, :boolean, default: false
  end
end
