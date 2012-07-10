class RelCommandeProduit < ActiveRecord::Base
	belongs_to :commande
	belongs_to :produit_vente_libre
	belongs_to :user
end
