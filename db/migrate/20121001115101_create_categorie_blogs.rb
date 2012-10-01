class CreateCategorieBlogs < ActiveRecord::Migration
  def change
    create_table :categorie_blogs do |t|
      t.integer :categorie_blog_id
      t.integer :user_id
      t.string :titre
      t.string :description
      t.integer :deleted

      t.timestamps
    end
  end
end
