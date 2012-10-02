class Administration::PanierAutorisesController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID
protect_from_forgery :except => [:create_declinaison,:supp_declinaison]

#________________ INDEX ____________________________________________
  def index
  	@admin_basket = true
  	
  	@panier_autorises = PanierAutorise.where('user_id =? AND deleted = "0"', params[:user_id])
    authorize! :manage, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
  end
 
#__________________ SHOW __________________________________________
  def show
  	@panier_autorise = PanierAutorise.find(params[:id])
  	
  	@declinaison_panier = DeclinaisonPanierAutorise.where('panier_autorise_id = ?', @panier_autorise.id )
		#@panier_correspondant.push(@panier)
	  	
	  	@panier_autorise_decli = {
		  	:panier => {
			  	:id => @panier_autorise.id,
			  	:user_id => @panier_autorise.user_id,
			  	:categorie_id => @panier_autorise.categorie_id,
			  	:titre => @panier_autorise.titre,
			  	:description => @panier_autorise.description,
		  	},
		  	:declinaison_panier => @declinaison_panier,		  	
	  	}
	  	
	  	respond_to do |format|
	  		format.json { render :json => {
	  			:status => "OK",
	  			:panier_autorise => @panier_autorise_decli[:panier],
	  			:declinaison_panier_autorise => @panier_autorise_decli[:declinaison_panier]		  			
	  			}
	  		}
	  		format.html { render :show }
	  	end
  end
#________________ CREATE ____________________________________________
  def create
  	@panier_autorise = PanierAutorise.new(params[:panier_autorise])
  	@panier_autorise.user_id = current_user.id
  	@panier_autorise.deleted = 0
  	
  	if @panier_autorise.save
  		flash[:notice] = "Panier ajoute"
		render :partial => 'card_panier', :locals => {:panier_autorise => @panier_autorise}  	 		
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'new'
  	end
  end
  
#_________________ UPDATE ______________________________________________
  def update
  	if @panier_autorise.update_attributes(params[:panier_autorise])
  		flash[:notice] = 'Panier autorise modifie'
  		respond_to do |format|
	  		format.json { render :json => {
	  			:status => "OK",
	  			:panier_autorise => @panier_autorise,	  			
	  			}
	  		}
	  		format.html { redirect_to administration_user_panier_autorise_path(params[:user_id],@panier_autorise) }
	  	end
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		respond_to do |format|
	  		format.json { render :json => {
	  			:status => "error",
	  			:error => flash[:notice],	  			
	  			}
	  		}
	  		format.html { render 'edit' }
	  	end
  	end
  
  end
  
  
  
  #--------------------------------------------------------
  #----------------------- DECLINAISON --------------------
  #--------------------------------------------------------
  #_______ CREATE DECLINAISON________
	def create_declinaison
		@panier_autorise_model = PanierAutorise.find(params[:panier][:id])
		@declinaison_panier_autorise = DeclinaisonPanierAutorise.where('panier_autorise_id = ?', @panier_autorise_model.id)
		@declinaison_exist = false
		@declinaison_panier_autorise.each do |panier_|
			if panier_.nombre_personne.to_i == params[:declinaison_panier_autorise][:nombre_personne].to_i && panier_.duree.to_i == params[:declinaison_panier_autorise][:duree].to_i 
				@declinaison_exist = true
			end
		end
		
		
		if @declinaison_exist == false
			@declinaison_panier_autorise = DeclinaisonPanierAutorise.new()
			@declinaison_panier_autorise.panier_autorise_id = @panier_autorise_model.id
			@declinaison_panier_autorise.prix_panier_ht = params[:declinaison_panier_autorise][:prix_panier_ht]
			@declinaison_panier_autorise.prix_panier_ttc = params[:declinaison_panier_autorise][:prix_panier_ttc]
			@declinaison_panier_autorise.nombre_personne = params[:declinaison_panier_autorise][:nombre_personne]
			@declinaison_panier_autorise.duree = params[:declinaison_panier_autorise][:duree]
			if @declinaison_panier_autorise.save
				respond_to do |format|
			  		format.json { render :json => {
				  		:status => "OK",
				  		:error => 'Declinaison ajoute',
				  		:declinaison_panier_autorise => @declinaison_panier_autorise
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
	
	#
	def get_declinaison
		@declinaison_panier_autorise = DeclinaisonPanierAutorise.find(params[:declinaison_id])
		
		render :json => {
			:declinaison_panier_autorise => @declinaison_panier_autorise
		}
	end
	
	#DELETE DECLINAISON
	def supp_declinaison
		declinaison_panier_autorise = DeclinaisonPanierAutorise.find(params[:declinaison_panier_autorise_id])
		count_declinaison = DeclinaisonPanierAutorise.where(:panier_autorise_id => declinaison_panier_autorise.panier_autorise_id).count
		if count_declinaison > 1
			declinaison_panier_autorise.destroy
			respond_to do |format|
					format.json { render :json => {
							  		:status => "OK",
							  		:error => 'Declinaison supprime'
							  		} 
							  	}
			end
		else
			respond_to do |format|
					format.json { render :json => {
							  		:status => "error",
							  		:error => 'Il doit y avoir au moins une declinaison'
							  		} 
							  	}
			end
		end
			
	end


end
