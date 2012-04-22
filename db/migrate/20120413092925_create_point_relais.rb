class CreatePointRelais < ActiveRecord::Migration
  def change
    create_table :point_relais do |t|
      t.integer :id
      t.integer :user_id
      t.integer :ville_id
      t.string :adresse
      t.integer :deleted

      t.timestamps
    end
  end
end
