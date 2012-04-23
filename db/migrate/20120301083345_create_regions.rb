class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :id
      t.string :nom
      t.integer :cp
      t.integer :deleted

      t.timestamps
    end
  end
end
