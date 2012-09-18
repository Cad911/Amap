class CreateDeclinaisonPaniers < ActiveRecord::Migration
  def change
    create_table :declinaison_paniers do |t|
      t.integer :panier_id
      t.integer :nb_pack
      t.integer :duree
      t.integer :nombre_personne
      t.float :prix_panier_ht
      t.float :prix_panier_ttc

      t.timestamps
    end
  end
end
