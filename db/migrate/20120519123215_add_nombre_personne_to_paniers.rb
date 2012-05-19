class AddNombrePersonneToPaniers < ActiveRecord::Migration
  def change
    add_column :paniers, :nombre_personne, :integer

  end
end
