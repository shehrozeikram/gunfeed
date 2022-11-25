class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.string :body
      t.string :image

      t.timestamps
    end
  end
end
