class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :id
      t.string :genre
      t.string :nom
      t.string :prenom
      t.string :adresse
      t.string :ville
      t.integer :code_postal
      t.string :pays
      t.integer :telephone
      t.date :naissance
      t.integer :newsletter
      t.integer :point_relai_id

      t.timestamps
    end
  end
end
