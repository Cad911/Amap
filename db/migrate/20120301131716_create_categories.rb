class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :id
      t.string :nom
      t.string :abbreviation
      t.integer :deleted

      t.timestamps
    end
  end
end
