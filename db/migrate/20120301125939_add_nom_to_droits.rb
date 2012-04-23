class AddNomToDroits < ActiveRecord::Migration
  def change
    add_column :droits, :nom, :string

  end
end
