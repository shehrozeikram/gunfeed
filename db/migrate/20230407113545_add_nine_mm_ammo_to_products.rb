class AddNineMmAmmoToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :nine_mm_ammo, :boolean
  end
end
