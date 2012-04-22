class AddUserIdToProduitVenteLibres < ActiveRecord::Migration
  def change
    add_column :produit_vente_libres, :user_id, :integer

  end
end
