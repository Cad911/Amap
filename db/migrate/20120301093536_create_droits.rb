class CreateDroits < ActiveRecord::Migration
  def change
    create_table :droits do |t|
      t.integer :id
      t.integer :has_revendeur
      t.integer :autorisation_produit
      t.integer :can_stock_sr
      t.integer :can_stock_ar
      t.integer :deleted

      t.timestamps
    end
  end
end
