class Panier < ActiveRecord::Base
	
	belongs_to :user, :class_name => "User",:foreign_key => "revendeur_id"
    belongs_to :categorie 
    belongs_to :panier_autorise
    
    has_many :produit_paniers
end
