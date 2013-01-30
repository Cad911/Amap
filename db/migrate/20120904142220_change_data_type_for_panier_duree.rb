class ChangeDataTypeForPanierDuree < ActiveRecord::Migration
	def change
		connection.execute(%q{
		    alter table paniers
		    alter column duree
		    type integer using cast(duree as integer)
		})
    	# change_column :paniers, :duree, :integer
    end
end
