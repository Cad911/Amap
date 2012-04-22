class CreateProduitVenteLibres < ActiveRecord::Migration
  def change
    create_table :produit_vente_libres do |t|
      t.integer :stock_id
      t.string :titre
      t.text :description
      t.float :quantite
      t.integer :nombre_pack
      t.float :prix_unite_ht
      t.float :prix_unite_ttc
      t.integer :alaune
      t.integer :deleted

      t.timestamps
    end
  end
end
