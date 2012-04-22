class RelCageotProduit < ActiveRecord::Base
	belongs_to :cageot
	belongs_to :produit_vente_libre
	
	
	def ajoutQuantite
		self.nombre_pack += 1
		self.save
	end
	
	def suppQuantite
		self.nombre_pack -= 1
		self.save
	end
end
