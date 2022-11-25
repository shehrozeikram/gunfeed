class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.string :image, as: :file
      t.string :video, as: :file

      t.timestamps
    end
  end
end
