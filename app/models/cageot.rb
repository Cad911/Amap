class Cageot < ActiveRecord::Base
  belongs_to :client
  
  has_many :rel_cageot_produits
  has_one :commande
  
  def total
  	@all_product = RelCageotProduit.where("cageot_id = ? ",self.id)
  	@total = 0
  	@all_product.each do |product|
  		@total += product.produit_vente_libre.prix_unite_ttc * product.nombre_pack
  	end
  	return @total
  end
end
