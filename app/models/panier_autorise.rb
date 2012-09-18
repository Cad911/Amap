class PanierAutorise < ActiveRecord::Base
	belongs_to :user
	belongs_to :categorie
	
	has_many :paniers
	has_many :declinaison_panier_autorise
end
