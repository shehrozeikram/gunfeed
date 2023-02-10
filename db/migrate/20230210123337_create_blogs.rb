class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.text :attachments
      t.text :video

      t.timestamps
    end
  end
end
