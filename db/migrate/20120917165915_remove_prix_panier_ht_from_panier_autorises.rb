class RemovePrixPanierHtFromPanierAutorises < ActiveRecord::Migration
  def up
    remove_column :panier_autorises, :prix_panier_ht
    remove_column :panier_autorises, :prix_panier_ttc
    
    remove_column :paniers, :prix_unite_ht
    remove_column :paniers, :prix_unite_ttc
    remove_column :paniers, :nb_pack
    remove_column :paniers, :nombre_personne
    remove_column :paniers, :duree
    
    add_column :abonnements, :nombre_personne, :integer
    add_column :abonnements, :prix_ht, :float
    add_column :abonnements, :prix_ttc, :float
  end

  def down
    add_column :panier_autorises, :prix_panier_ht, :float
    add_column :panier_autorises, :prix_panier_ttc, :float
    
    add_column :paniers, :prix_unite_ht, :float
    add_column :paniers, :prix_unite_ttc, :float
    add_column :paniers, :nb_pack, :integer
    add_column :paniers, :nombre_personne, :integer
    add_column :paniers, :duree, :integer
    
    remove_column :abonnements, :nombre_personne
    remove_column :abonnements, :prix_ht
    remove_column :abonnements, :prix_ttc
  end
end
