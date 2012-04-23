class AddCategorieIdToPaniers < ActiveRecord::Migration
  def change
    add_column :paniers, :categorie_id, :integer

  end
end
