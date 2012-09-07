class Administration::PaniersController < InheritedResources::Base
#load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID
protect_from_forgery :except => [:create_declinaison,:produit_stock_already_in] #car erreur lors de l'ajout en ajax, il n'y a pas le bon header de transmis (à voir plus tard) 
	#_______ INDEX _________
	def index
	    @admin_basket = true
		@panier_ = Panier.where(:revendeur_id => params[:user_id]).order('panier_autorise_id')
		@panier_autorise = 0
		@paniers = []
		@panier_.each do |panier|
				if @panier_autorise != panier.panier_autorise_id
					@paniers.push(panier)	
				end
				@panier_autorise = panier.panier_autorise_id
		end
		authorize! :update, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
	end
	
	#_______ SHOW ________
	def show
		#___ On affiche les produits se trouvant dans le panier ___
		@produit_paniers = ProduitPanier.where(:panier_id => params[:id])
		@photo_panier = PhotoPanier.new
		@panier = Panier.find(params[:id])
		
		@declinaison_panier = Panier.where('panier_autorise_id = ? AND revendeur_id = ? ', @panier.panier_autorise_id , @panier.revendeur_id )
		#@panier_correspondant.push(@panier)
	  	
	  	@panier_produit_panier = {
		  	:panier => {
			  	:id => @panier.id,
			  	:user_id => @panier.revendeur_id,
			  	:categorie_id => @panier.categorie_id,
			  	:nb_pack => @panier.nb_pack,
			  	:titre => @panier.titre,
			  	:description => @panier.description,
		  	},
		  	:declinaison_panier => @declinaison_panier,
		  	:produit_paniers => @produit_paniers		  	
	  	}
	  	
	  	respond_to do |format|
	  		format.json { render :json => {
	  			:status => "OK",
	  			:panier => @panier_produit_panier[:panier],
	  			:declinaison_panier => @panier_produit_panier[:declinaison_panier], 
	  			:produit_paniers => @panier_produit_panier[:produit_paniers]		  			
	  			}
	  		}
	  		format.html { render :show }
	  	end
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
  		if current_user.can_stock_ar && !params[:panier][:panier_autorise_id].nil?
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
	  		flash[:notice] = 'Panier modifie'
			
			respond_to do |format|
		  		format.json { render :json => {
		  			:status => "OK"
		  			}
		  		 }
		  		format.html { redirect_to administration_user_panier_path(params[:user_id],@panier) }
		  	end
	  	else
	  		respond_to do |format|
		  		format.json { render :json => {
			  		:status => "error",
			  		:error => 'Une erreur est survenue'
			  		} 
			  	}
		  		format.html { 
		  			flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
		  			render 'edit' 
		  		}
		  	end
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


	#_______ CREATE DECLINAISON________
	def create_declinaison
		@panier_model = Panier.find(params[:panier][:id])
		@declinaison_panier = Panier.where('panier_autorise_id = ? AND revendeur_id = ?', @panier_model.panier_autorise_id, @panier_model.revendeur_id)
		@declinaison_exist = false
		@declinaison_panier.each do |panier_|
			if panier_.nombre_personne.to_i == params[:panier][:nombre_personne].to_i && panier_.duree.to_i == params[:panier][:duree].to_i 
				@declinaison_exist = true
			end
		end
		
		
		if @declinaison_exist == false
			@panier = Panier.new()
			@panier.titre = @panier_model.titre
			@panier.description = @panier_model.description
			@panier.prix_unite_ht = @panier_model.prix_unite_ht
			@panier.prix_unite_ttc = @panier_model.prix_unite_ttc
			@panier.panier_autorise_id = @panier_model.panier_autorise_id
			@panier.revendeur_id = @panier_model.revendeur_id
			@panier.categorie_id = @panier_model.categorie_id
			@panier.nb_pack = params[:panier][:nb_pack]
			@panier.nombre_personne = params[:panier][:nombre_personne]
			@panier.duree = params[:panier][:duree]
			if @panier.save
				respond_to do |format|
			  		format.json { render :json => {
				  		:status => "OK",
				  		:error => 'Declinaison ajoute'
				  		} 
				  	}
			  		format.html { 
			  			flash[:notice] = 'La declinaison existe deja'
			  			render 'new' 
			  		}
			  	end
			 end
		
		else
			respond_to do |format|
		  		format.json { render :json => {
			  		:status => "error",
			  		:error => 'La declinaison existe deja'
			  		} 
			  	}
		  		format.html { 
		  			flash[:notice] = 'La declinaison existe deja'
		  			render 'new' 
		  		}
		  	end
		end	
	end
	
	
	def get_all_product
		@produit_panier = ProduitPanier.where(:panier_id => params[:panier_id])
		
		render :partial => 'get_all_product', :locals => {:produit_panier => @produit_panier}
	end
	
	def get_one_product
		@produit_panier = ProduitPanier.find(params[:produit_panier_id])
		render :partial => 'get_one_product', :locals => {:produit_panier => @produit_panier}
	end
	
	def produit_stock_already_in
		@produit_in = ProduitPanier.where('stock_id = ? AND panier_id = ?', params[:stock_id], params[:panier_id])
		@status = 'OK'
		@error = 'OK'
		if @produit_in.count > 0
			@status = 'error'
			@error = 'Le produit est deja dans le panier'
		end
		
		respond_to do |format|
		  		format.json { render :json => {
			  		:status => @status,
			  		:error => @error
			  		} 
			  	}
		end
		
	end
#   def delete
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
