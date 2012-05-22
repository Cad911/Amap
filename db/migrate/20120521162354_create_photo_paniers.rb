class CreatePhotoPaniers < ActiveRecord::Migration
  def change
    create_table :photo_paniers do |t|
      t.integer :panier_id
      t.string :image
      t.integer :first_image

      t.timestamps
    end
  end
end
