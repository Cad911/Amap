class ChangeDataTypeForAbonnementDuree < ActiveRecord::Migration
  def up
  	  rename_column :abonnements, :duree, :duree_
	  add_column :abonnements, :duree, :integer

	  remove_column :abonnements, :duree_
      #change_column :abonnements, :duree, :integer
  end

  def down
  end
end
