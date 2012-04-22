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
end
