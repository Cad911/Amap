class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :id
      t.integer :user_id
      t.integer :categorie_id
      t.integer :unite_mesure_id
      t.float :quantite
      t.string :titre
      t.text :description
      t.integer :deleted

      t.timestamps
    end
  end
end
