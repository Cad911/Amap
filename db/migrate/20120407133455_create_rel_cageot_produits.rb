class CreateRelCageotProduits < ActiveRecord::Migration
  def change
    create_table :rel_cageot_produits do |t|
      t.integer :id
      t.integer :produit_vente_libre_id
      t.integer :cageot_id
      t.integer :nombre_pack
      t.integer :deleted

      t.timestamps
    end
  end
end
