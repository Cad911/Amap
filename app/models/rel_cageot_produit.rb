class RelCageotProduit < ActiveRecord::Base
	belongs_to :cageot
	has_many :produit_vente_libres
end
