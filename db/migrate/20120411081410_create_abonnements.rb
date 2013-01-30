class CreateAbonnements < ActiveRecord::Migration
  def change
    create_table :abonnements do |t|
      t.integer :id
      t.integer :client_id
      t.integer :panier_id
      t.date :date_debut
      t.date :date_fin
      t.date :integer
      t.integer :deleted

      t.timestamps
    end
  end
end
