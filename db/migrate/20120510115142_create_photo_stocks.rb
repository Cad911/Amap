class CreatePhotoStocks < ActiveRecord::Migration
  def change
    create_table :photo_stocks do |t|
      t.integer :stock_id
      t.string :image
      t.integer :first_image

      t.timestamps
    end
  end
end
