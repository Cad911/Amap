class Panier < ActiveRecord::Base
	
	belongs_to :user, :class_name => "User",:foreign_key => "revendeur_id"
    belongs_to :categorie 
    belongs_to :panier_autorise
    
    has_many :produit_paniers
    has_many :abonnements
    
    has_many :photo_paniers
    
    attr_accessor :duree
    
    
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
