class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.integer :entite_id
      t.integer :direction_id
      t.integer :ville_id
      t.integer :mode_denvoi_id
      t.string :genre
      t.string :nom
      t.string :prenom
      t.string :nom_societe
      t.text :description
      t.string :adresse
      t.integer :telephone
      t.date :naissance
      t.integer :alaune

      t.timestamps
    end
  end
end
