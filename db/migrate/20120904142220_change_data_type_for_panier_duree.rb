class ChangeDataTypeForPanierDuree < ActiveRecord::Migration
	def change
    	change_column :paniers, :duree, :integer
    end
end
