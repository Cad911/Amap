class Commande < ActiveRecord::Base
	belongs_to :client
	belongs_to :cageot
	belongs_to :point_relai
	
	has_many :rel_commande_produits
end
