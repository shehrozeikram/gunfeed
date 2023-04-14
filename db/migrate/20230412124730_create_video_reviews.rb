class CreateVideoReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :video_reviews do |t|
      t.string :link
      t.integer :product_id

      t.timestamps
    end
  end
end
