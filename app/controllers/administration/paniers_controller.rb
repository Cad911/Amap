class Administration::PaniersController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID	
	#_______ INDEX _________
	def index
		@panier = Panier.where(:revendeur_id => params[:user_id])
		authorize! :update, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
	end
	
	#_______ SHOW ________
	def show
		#___ On affiche les produits se trouvant dans le panier ___
		@produit_paniers = ProduitPanier.where(:panier_id => params[:id])
		@photo_panier = PhotoPanier.new
	end
	
	
	
# 	#_______ EDIT ________
# 	def edit
# 	
# 	end
# 	
# 	#_______ UPDATE ________
 	def update
		@panier = Panier.find(params[:id])
		@panier.attributes = params[:panier]
		@panier.revendeur_id = params[:user_id]
		#_______ CONDITION CAN STOCK AR ______ 
  		if current_user.can_stock_ar
  			@panier_autorise = PanierAutorise.find(params[:panier][:panier_autorise_id])
  			@panier.titre = @panier_autorise.titre
  			@panier.description = @panier_autorise.description
  			@panier.categorie_id = @panier_autorise.categorie_id
  			@panier.prix_unite_ht = @panier_autorise.prix_panier_ht
  			@panier.prix_unite_ttc = @panier_autorise.prix_panier_ttc

  		#_______ CAN STOCK SR _______
  		elsif current_user.can_stock_sr
  		
  		end
	
		if @panier.save
			flash[:notice] = "Panier modifier"
			redirect_to administration_user_panier_path(params[:user_id],@panier)
		else
			flash[:notice] = "ERREUR"
			render :new
		end
 	end
	
	
	#_______ NEW ________
	def new
		@panier = Panier.new
		authorize! :update, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
	end
	
	#_______ CREATE ________
	def create
		@panier = Panier.new(params[:panier])
		
		#_______ CONDITION CAN STOCK AR ______ 
  		if current_user.can_stock_ar
  			@panier_autorise = PanierAutorise.find(params[:panier][:panier_autorise_id])
  			@panier.titre = @panier_autorise.titre
  			@panier.description = @panier_autorise.description
  			@panier.categorie_id = @panier_autorise.categorie_id
  			@panier.prix_unite_ht = @panier_autorise.prix_panier_ht
  			@panier.prix_unite_ttc = @panier_autorise.prix_panier_ttc

  		#_______ CAN STOCK SR _______
  		elsif current_user.can_stock_sr
  		
  		end
  		
			
		@panier.revendeur_id = params[:user_id]
			
			if @panier.save
				flash[:notice] = "Panier ajoute"
				redirect_to administration_user_panier_path(params[:user_id],@panier)
			else
				flash[:notice] = "ERREUR"
				render :new
			end
	end
	
	# def delete
# 	
# 	end



   #____________________________________________________________________________________
  #____________________________________________________________________________________
  #__________________________________ IMAGE ___________________________________________
  #____________________________________________________________________________________
  #____________________________________________________________________________________
  
  #_________________________________ ADD IMAGE _______________________________________
  def add_image
    @panier = Panier.find(params[:panier_id])
    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
	if params[:photo_panier][:first_image] == "1"
		@photo_first_image = PhotoPanier.where('panier_id = ? AND first_image = "1"', @panier.id)
		if @photo_first_image.count > 0
			@photo_first_image[0].first_image = 0
			@photo_first_image[0].save	
		end
	else
		@photo_first_image = PhotoPanier.where('panier_id = ? AND first_image = "1"', @panier.id)
		#__ SI PAS ENCORE DIMAGE PAR DEFAUT, ON L'APPLIQUE __
		if @photo_first_image.count == 0
			params[:photo_panier][:first_image] = "1"
		end
	end
	@photo_panier = PhotoPanier.new
	@photo_panier.panier_id = @panier.id
	@photo_panier.update_attributes(params[:photo_panier])
	redirect_to [:administration,current_user,@panier]
  end
  
  
  #_________________________________ UPDATE  IMAGE _______________________________________
  def update_image
    @panier = Panier.find(params[:panier_id])
    @image = PhotoPanier.find(params[:image_id])
    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
	if params[:photo_panier][:first_image] == "1"
		#___ SI PAS DE CHANGEMENT ______
		if @image.first_image == 1
			flash[:notice] = "Aucun changement"
		else
			@photo_first_image = PhotoPanier.where('panier_id = ? AND first_image = "1"', @panier.id)
			if @photo_first_image.count > 0
				@photo_first_image[0].first_image = 0
				@photo_first_image[0].save	
			end
			@image.first_image = params[:photo_panier][:first_image]
			@image.save
			flash[:notice] = "Modification photo stock effectuer"
		end
	else
		#___ SI ON ENLEVE L IMAGE PAR DEFAUT ______
		if @image.first_image == 1
			flash[:notice] = "Il est obligatoire d avoir une image par defaut"
		else
			flash[:notice] = "Aucun changement"
		end
	end
	redirect_to [:administration,current_user,@panier]
  end
  
  #____________________________ DELETE IMAGE _________________________________________________
  def delete_image
  	@image_panier = PhotoPanier.find(params[:image_id])
  	@image_panier.remove_image = true
  	@image_panier.destroy
  end


end
