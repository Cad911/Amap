class AddPanierAutoriseIdToPanier < ActiveRecord::Migration
  def change
    add_column :paniers, :panier_autorise_id, :integer

  end
end
