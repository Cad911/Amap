class CreateUniteMesures < ActiveRecord::Migration
  def change
    create_table :unite_mesures do |t|
      t.integer :id
      t.string :nom
      t.string :abbreviation
      t.integer :deleted

      t.timestamps
    end
  end
end
