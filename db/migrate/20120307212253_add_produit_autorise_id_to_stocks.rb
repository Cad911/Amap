class AddProduitAutoriseIdToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :produit_autorise_id, :integer

  end
end
