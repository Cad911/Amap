class Stock < ActiveRecord::Base
  attr_accessor :id_user_input,:unite_mesure_info
  
  belongs_to :user
  belongs_to :categorie
  belongs_to :unite_mesure
  belongs_to :produit_autorise
  
  has_many :produit_vente_libres
  has_many :produit_paniers
  
  #_______________________ Quantite des produits en vente ________________
  def quantiteProduitVente
  	produitEnLigne = ProduitVenteLibre.where(:stock_id => self.id)
  	quantite = 0
  	
  	if produitEnLigne.count > 0
  		produitEnLigne.each do |produit|
	  		quantite += produit.quantiteTotal
	  	end
	end

	return quantite
  end
  
end
