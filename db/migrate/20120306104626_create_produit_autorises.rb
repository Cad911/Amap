class CreateProduitAutorises < ActiveRecord::Migration
  def change
    create_table :produit_autorises do |t|
      t.integer :id
      t.integer :user_id
      t.integer :categorie_id
      t.string :titre
      t.text :description
      t.integer :deleted

      t.timestamps
    end
  end
end
