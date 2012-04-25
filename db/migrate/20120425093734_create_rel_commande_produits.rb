class CreateRelCommandeProduits < ActiveRecord::Migration
  def change
    create_table :rel_commande_produits do |t|
      t.integer :id
      t.integer :produit_vente_libre_id
      t.integer :commande_id
      t.float :prix_unite_ht
      t.float :prix_unite_ttc
      t.integer :nb_pack
      t.integer :quantite

      t.timestamps
    end
  end
end
