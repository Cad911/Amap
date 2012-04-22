class CreateCageots < ActiveRecord::Migration
  def change
    create_table :cageots do |t|
      t.integer :id
      t.integer :client_id
      t.string :etat

      t.timestamps
    end
  end
end
