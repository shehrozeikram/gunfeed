class AddCaliforniaLegalToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :california_legal, :boolean, default: false
  end
end
