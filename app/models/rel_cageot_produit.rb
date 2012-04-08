class RelCageotProduit < ActiveRecord::Base
	belongs_to :cageot
	belongs_to :produit_vente_libre
end
