class CreateEntites < ActiveRecord::Migration
  def change
    create_table :entites do |t|
      t.integer :id
      t.integer :droit_id
      t.string :nom
      t.integer :deleted

      t.timestamps
    end
  end
end
