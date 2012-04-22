class CreateProduitPaniers < ActiveRecord::Migration
  def change
    create_table :produit_paniers do |t|
      t.integer :id
      t.integer :panier_id
      t.integer :stock_id
      t.string :titre
      t.text :description
      t.integer :quantite
      t.integer :deleted

      t.timestamps
    end
  end
end
