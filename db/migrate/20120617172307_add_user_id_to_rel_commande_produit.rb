class AddUserIdToRelCommandeProduit < ActiveRecord::Migration
  def change
    add_column :rel_commande_produits, :user_id, :integer

  end
end
