class CreatePhotoUsers < ActiveRecord::Migration
  def change
    create_table :photo_users do |t|
      t.integer :user_id
      t.string :image
      t.integer :first_image

      t.timestamps
    end
  end
end
