class CreateDeclinaisonPanierAutorises < ActiveRecord::Migration
  def change
    create_table :declinaison_panier_autorises do |t|
      t.integer :panier_autorise_id
      t.integer :duree
      t.integer :nombre_personne
      t.integer :prix_panier_ht
      t.integer :prix_panier_ttc
      t.integer :deleted

      t.timestamps
    end
  end
end
