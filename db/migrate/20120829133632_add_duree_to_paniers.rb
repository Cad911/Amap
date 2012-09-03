class AddDureeToPaniers < ActiveRecord::Migration
  def change
    add_column :paniers, :duree, :string

  end
end
