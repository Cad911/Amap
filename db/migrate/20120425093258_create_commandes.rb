class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.integer :id
      t.integer :client_id
      t.integer :cageot_id
      t.integer :point_relai_id
      t.date :date_livraison
      t.float :total
      t.string :etat

      t.timestamps
    end
  end
end
