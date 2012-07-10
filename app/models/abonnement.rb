class Abonnement < ActiveRecord::Base
	belongs_to :panier
	belongs_to :point_relai
	
	belongs_to :client
end
