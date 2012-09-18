class Administration::ProduitPaniersController < InheritedResources::Base
	#load_and_authorize_resource
	
	#________ NEW ______________
	def new
		@produit_panier = ProduitPanier.new
		authorize!:manage, Panier.find(params[:panier_id])
	end
	
	#________ CREATE ______________
	def create
		#___ VERIF SI PRODUIT DU STOCK DANS PANIER___
		@produit_stock_panier = ProduitPanier.where("stock_id = ? AND panier_id = ?", params[:produit_panier][:stock_id],params[:panier_id])
		#__ SI EXIST __
		if @produit_stock_panier[0]
			#@produit_panier = ProduitPanier.find(@produit_stock_panier[0].id)
			#@produit_panier.attributes = params[:produit_panier]
			@message = "Le produit existe deja" #et, a donc etait modifie"
		else
			@produit_panier = ProduitPanier.new(params[:produit_panier])
			@message = "Produit ajoute au panier"
		end
		
		@stock = Stock.find(params[:produit_panier][:stock_id])
		
		@produit_panier.panier_id = params[:panier_id]
		@produit_panier.titre = @stock.titre
		@produit_panier.description= @stock.description
		
		if @produit_panier.save
			flash[:notice] = @message
			respond_to do |format|
		  		format.json { render :json => { 
		  				:produit_panier => @produit_panier
		  				} 
		  			}
		  		format.html { render :show }
		  	end
			#render :controller => :Panier, :action => :get_one_product, :produit_panier_id => @produit_panier.id
			#redirect_to administration_user_panier_path(params[:user_id],params[:panier_id])
		else
			flash[:notice] = "ERREUR"
			render :new
		end
		
	end
	
	#________ EDIT ______________
	def edit
	
	end
	
	
	#________ UPDATE ______________
	def update
		@produit_panier = ProduitPanier.find(params[:id])
		@stock = Stock.find(params[:produit_panier][:stock_id])
		
		@produit_panier.attributes = params[:produit_panier]
		@produit_panier.panier_id = params[:panier_id]
		@produit_panier.titre = @stock.titre
		@produit_panier.description= @stock.description
		
		if @produit_panier.save
			flash[:notice] = "Produit modifie"
			redirect_to administration_user_panier_path(params[:user_id],params[:panier_id])
		else
			flash[:notice] = "ERREUR"
			render :edit		
		end
	end
end
