class AddEmailToNewsLetters < ActiveRecord::Migration[7.0]
  def change
    add_column :news_letters, :email, :string
  end
end
