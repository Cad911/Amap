class CreateVilles < ActiveRecord::Migration
  def change
    create_table :villes do |t|
      t.integer :id
      t.integer :region_id
      t.string :nom
      t.integer :cp
      t.integer :deleted

      t.timestamps
    end
  end
end
