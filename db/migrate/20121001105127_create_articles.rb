class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :categorie_blog_id
      t.integer :mot_cle_id
      t.string :titre
      t.string :content
      t.string :url_first_image
      t.string :etat

      t.timestamps
    end
  end
end
