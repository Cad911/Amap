class ChangeDataTypeForAbonnementDuree < ActiveRecord::Migration
  def up
	  	connection.execute(%q{
		    alter table abonnements
		    alter column duree
		    type integer using cast(duree as integer)
		})
      #change_column :abonnements, :duree, :integer
  end

  def down
  end
end
