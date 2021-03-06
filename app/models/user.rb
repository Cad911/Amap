class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :produit_autorises
  has_many :panier_autorises
  has_many :stocks
  has_many :produit_vente_libres
  has_many :paniers,:foreign_key => "revendeur_id"
  has_many :point_relais
  has_many :photo_users
  has_many :rel_commande_produits
  
  belongs_to :entite
  belongs_to :ville
  belongs_to :direction, :class_name => "User",
    :foreign_key => "direction_id"
    
    
    def mes_commandes
    	#CONTINUEZ ICI BITCHT
    	@all_commande = Commande.where('etat = "paye"')
    	@cageot_ids = []
    	@all_commande_format = []
    	@ma_commande = false
    	@all_commande.each do |commande|
    		@ma_commande = false
    		#JE RECUPERE LES PRODUIT RELIE AU CAGEOT LIER LUI MEME A LA COMMANDE
    		commande.cageot.rel_cageot_produits.each do |produit_cageot|
    			#@all_commande << "test"
    			if produit_cageot.produit_vente_libre.stock.user_id == self.id
    				@ma_commande = true
    			end
    			break if @ma_commande
    		end
    		
    		if @ma_commande
    			@all_commande_format << commande
    		end
    		
    		#@cageot_ids << commande.id
    	end
    	
    	return @all_commande_format
    	
    	# @all_cageot = RelCageotProduit.where('cageot_id IN (?)',@cageot_ids)
#     	@produit_vente_libre_ids = []
#     	@all_cageot.each do |produit_cageot|
#     		@produit_vente_libre_ids << produit_cageot.produit_vente_libre_id
#     	end
#     	
#     	@
    	
    end
	#______ VERIFICATION DES DROITS _______________
    def has_revendeur
    	if(self.entite.droit.has_revendeur == 1)
    		return true
    	else
    		return false
    	end
    end
    
    def autorisation_produit
    	if(self.entite.droit.autorisation_produit == 1)
    		return true
    	else
    		return false
    	end
    end
  
  	def can_stock_ar
    	if(self.entite.droit.can_stock_ar == 1)
    		return true
    	else
    		return false
    	end
    end
    
    def can_stock_sr
    	if(self.entite.droit.can_stock_sr == 1)
    		return true
    	else
    		return false
    	end
    end
    
    
    
    #____________ RECUPERATION PRODUIT EN VENTE ________
    def produit_en_vente
        my_product_online = ProduitVenteLibre.where('user_id = ? AND deleted = 0', self.id)
    	return my_product_online.count
    end
    
    #___________ RECUPERATION PANIER EN VENTE ______
    def panier_en_vente
    	@paniers_ = Panier.where('revendeur_id = ? AND deleted = 0', self.id)
    	@paniers= []
    	@paniers_.each do |panier|
    		if panier.has_declinaison
    			@paniers << panier
    		end
    	end
    	
    	return @paniers.count
    end
    
    #NB_ALL_PRODUCT
    def nb_all_product
    	nb = self.produit_en_vente + self.panier_en_vente
    	return nb
    end
    
    #LISTING_ALL_produit_en_vente
    def list_produit_en_vente
       all_product = ProduitVenteLibre.where('user_id = ? AND deleted = 0', self.id)
       return all_product
    end
    
    #LISTING_ALL_paniert_en_vente
    def list_panier_en_vente
    	@paniers_ = Panier.where('revendeur_id = ? AND deleted = 0', self.id)
    	@paniers= []
    	@paniers_.each do |panier|
    		if panier.has_declinaison
    			@paniers << panier
    		end
    	end
    	return @paniers
    end
    
    #_____ IMAGE USER ________________________________
    def default_image
  	  @default_photo = PhotoUser.where('user_id = ? AND first_image = 1 AND image IS NOT NULL',self.id)
  	  if @default_photo.count > 0
  		@mydefault_photo = PhotoUser.find(@default_photo[0].id)
  		return @mydefault_photo
  	  else
  		return nil
  	  end
    end
  
    def other_image
  	  @other_image = PhotoUser.where('user_id = ? AND first_image = 0 AND image IS NOT NULL',self.id)
  	  if @other_image.count > 0
  		return @other_image
  	  else
  		return nil
  	  end
    end
end
