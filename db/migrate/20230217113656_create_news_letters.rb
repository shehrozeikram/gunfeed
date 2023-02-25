class CreateNewsLetters < ActiveRecord::Migration[7.0]
  def change
    create_table :news_letters do |t|
      t.boolean :subscribed
      t.integer :user_id

      t.timestamps
    end
  end
end
