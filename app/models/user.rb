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
  
  belongs_to :entite
  belongs_to :ville
  belongs_to :direction, :class_name => "User",
    :foreign_key => "direction_id"
    
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
    	return ProduitVenteLibre.where(:user_id => self.id).count
    end
    
    #___________ RECUPERATION PANIER EN VENTE ______
    def panier_en_vente
    	return Panier.where(:revendeur_id => self.id).count
    end
end
