class PanierAutorise < ActiveRecord::Base
	belongs_to :user
	belongs_to :categorie
	
	has_many :paniers
	has_many :declinaison_panier_autorise
	
	
	
	    def regroup_nombre_personne
    	@panier = DeclinaisonPanierAutorise.where('panier_autorise_id = ?', self.id)
    	@nb_personne = []
    	@panier.each do |panier|
    		@nb_personne.push(panier.nombre_personne)
    	end
    	
    	return @nb_personne
    end
    
    #pour administration
    def regroup_duree
    	@panier = DeclinaisonPanierAutorise.where('panier_autorise_id = ?', self.id)
    	@duree = []
    	@panier.each do |panier|
    		@duree.push(panier.duree)
    	end

    	return @duree
    end
end
