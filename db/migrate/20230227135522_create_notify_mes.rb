class CreateNotifyMes < ActiveRecord::Migration[7.0]
  def change
    create_table :notify_mes do |t|
      t.string :upc
      t.float :limite_price
      t.string :email

      t.timestamps
    end
  end
end
