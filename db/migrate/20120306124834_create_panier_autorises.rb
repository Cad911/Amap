class CreatePanierAutorises < ActiveRecord::Migration
  def change
    create_table :panier_autorises do |t|
      t.integer :id
      t.integer :user_id
      t.integer :categorie_id
      t.string :titre
      t.text :description
      t.float :prix_panier_ht
      t.float :prix_panier_ttc
      t.integer :deleted

      t.timestamps
    end
  end
end
