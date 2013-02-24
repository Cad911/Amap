class Stock < ActiveRecord::Base
  attr_accessor :id_user_input,:unite_mesure_info
  
  belongs_to :user
  belongs_to :categorie
  belongs_to :unite_mesure
  belongs_to :produit_autorise
  
  has_one :produit_vente_libre
  has_many :produit_paniers
  has_many :photo_stocks
  
  #_______________________ Quantite des produits en vente ________________
  def quantiteProduitVente
  	produitEnLigne = ProduitVenteLibre.where(:stock_id => self.id)
  	quantite = 0
  	
  	if produitEnLigne.count > 0
  		produitEnLigne.each do |produit|
	  		quantite += produit.quantiteTotal
	  	end
	end

	return quantite
  end
  
  
  def default_image
  	@default_photo = PhotoStock.where('stock_id = ? AND first_image = 1',self.id)
  	if @default_photo.count > 0
      if !@default_photo.nil?
    		@mydefault_photo = PhotoStock.find(@default_photo[0].id)
    		return @mydefault_photo

      return nil
  	else
  		return nil
  	end
  end
  
  def other_image
  	@other_image = PhotoStock.where('stock_id = ? AND first_image = 0',self.id)
  	if @other_image.count > 0
  		  @other_image.each do |image|
          if image.image.nil?
            @other_image.delete(image)
          end
        end
      return @other_image
  	else
  		return nil
  	end
  end
  
end
