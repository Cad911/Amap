class CreatePaniers < ActiveRecord::Migration
  def change
    create_table :paniers do |t|
      t.integer :id
      t.integer :revendeur_id
      t.string :titre
      t.text :description
      t.integer :nb_pack
      t.float :prix_unite_ht
      t.float :prix_unite_ttc
      t.integer :alaune
      t.integer :deleted

      t.timestamps
    end
  end
end
