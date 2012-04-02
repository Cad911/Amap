class ProduitVenteLibre < ActiveRecord::Base
	belongs_to :stock
	belongs_to :user
	
	
	#POUR AJAX, ON A BESOIN DE L'ID USER
	attr_accessor :id_user_input
	attr_accessible :id_user_input,:stock_id,:titre,:description,:quantite,:nombre_pack,:prix_unite_ht,:prix_unite_ttc,:alaune
	
	validates :quantite, :presence => true , :numericality => true
	validates :nombre_pack, :presence => true , :numericality => true
	validates :prix_unite_ht, :presence => true, :numericality => true
	validates :prix_unite_ttc, :presence => true, :numericality => true
	
	
	
	
	
  #_______________________ quantite en ligne___________________________________________________
  def quantiteTotal
  	  quantite_total_online = self.nombre_pack * self.quantite
  	  return quantite_total_online
  end
  
  
end
