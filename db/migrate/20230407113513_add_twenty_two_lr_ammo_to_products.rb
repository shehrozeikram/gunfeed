class AddTwentyTwoLrAmmoToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :twenty_two_lr_ammo, :boolean
  end
end
