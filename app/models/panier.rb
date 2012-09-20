class Panier < ActiveRecord::Base
	
	belongs_to :user, :class_name => "User",:foreign_key => "revendeur_id"
    belongs_to :categorie 
    belongs_to :panier_autorise
    
    has_many :produit_paniers
    has_many :abonnements
    has_many :declinaison_panier
    
    has_many :photo_paniers
    
    attr_accessor :declinaison_id
    
    
    #min_duree
    def min_duree
    
    end
    
    #get min personne of declinaison
    def min_personne
    	@declinaison = DeclinaisonPanier.where('panier_id = ?', self.id)
    	if @declinaison.count > 0
    		@min = @declinaison[0].nombre_personne
    		@declinaison.each do |decli|
	    		if decli.nombre_personne  < @min
	    			@min = decli.nombre_personne
	    		end
	    	end
	    	
	    	return @min
	    else
	    	return 0
    	end
    end
    
    
    #get min price of declinaison
    def min_price
    	@declinaison = DeclinaisonPanier.where('panier_id = ?', self.id)
    	if @declinaison.count > 0
    		@min = @declinaison[0].prix_panier_ttc
    		@declinaison.each do |decli|
	    		if decli.prix_panier_ttc  < @min
	    			@min = decli.prix_panier_ttc
	    		end
	    	end
	    	
	    	return @min
	    else
	    	return 0
    	end
    	
    end
    
    #pour administration
    def regroup_max
    	@panier = DeclinaisonPanier.where('panier_id = ?', self.id)
    	@max = 0
    	@panier.each do |panier|
    		@max += panier.nb_pack
    	end
    	
    	return @max
    end
    
    def regroup_nombre_personne
    	@panier = DeclinaisonPanier.where('panier_id = ?', self.id)
    	@nb_personne = []
    	@panier.each do |panier|
    		@nb_personne.push(panier.nombre_personne)
    	end
    	
    	return @nb_personne
    end
    
    #pour administration
    def regroup_duree
    	@panier = DeclinaisonPanier.where('panier_id = ?', self.id)
    	@duree = []
    	@panier.each do |panier|
    		@duree.push(panier.duree)
    	end

    	return @duree
    end
    
    
    #___ nb produit dans panier
    def product_number
    	#@number_product = ProduitPanier.where(:)
    	return self.produit_paniers.count
    end
    
    #___ nb personne inscrite
    def customer_number
    	@today = Date.today #return aaaa-mm-jj
	    @number_customer = Abonnement.where('panier_id = ? AND etat = "paye" AND date_fin >= ?',self.id,@today).count
	    
	    return @number_customer
    	#@number_customer = Abonnement.where()
    end
    
    
    #_____ IMAGE USER ________________________________
    def default_image
  	  @default_photo = PhotoPanier.where('panier_id = ? AND first_image = "1"',self.id)
  	  if @default_photo.count > 0
  		@mydefault_photo = PhotoPanier.find(@default_photo[0].id)
  		return @mydefault_photo
  	  else
  		return nil
  	  end
    end
  
    def other_image
  	  @other_image = PhotoPanier.where('panier_id = ? AND first_image = "0"',self.id)
  	  if @other_image.count > 0
  		return @other_image
  	  else
  		return nil
  	  end
    end

end
