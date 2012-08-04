class Administration::StocksController < InheritedResources::Base


  #________________ INDEX ____________________________________________
  def index
  	@stocks = Stock.where(:user_id => params[:user_id])
   	authorize! :update, User.find(params[:user_id]) #TRADUCTION : EST-IL AUTORISE A UPDATER CETTE UTILISATEUR ?
  end

  #__________________ SHOW __________________________________________
  def show
  	@stock = Stock.find(params[:id])
  	#A ENLEVER
  	@stock.unite_mesure_info = @stock.unite_mesure.nom
  	#____
  	@unite_mesure = UniteMesure.find(@stock.unite_mesure_id)
  	@photo_stock = PhotoStock.new
  	
  	@stock_produit_vente_libre = {
	  	:stock => {
		  	:id => @stock.id,
		  	:user_id => @stock.user_id,
		  	:categorie_id => @stock.categorie_id,
		  	:quantite => @stock.quantite,
		  	:titre => @stock.titre,
		  	:description => @stock.description,
	  	},
	  	
	  	:unite_mesure => {
		  	:id => @unite_mesure.id,
		  	:nom => @unite_mesure.nom,
		  	:abbreviation => @unite_mesure.abbreviation,
	  	},
	  	
	  	:produit_vente_libre => {
	  		:id => @stock.produit_vente_libre.id,
		  	:stock_id => @stock.produit_vente_libre.stock_id,
		  	:titre => @stock.produit_vente_libre.titre,
		  	:description => @stock.produit_vente_libre.description,
		  	:quantite => @stock.produit_vente_libre.quantite,
		  	:nombre_pack => @stock.produit_vente_libre.nombre_pack,
		  	:lot_possible_max => @stock.produit_vente_libre.lotPossibleMax,
		  	:prix_unite_ht => @stock.produit_vente_libre.prix_unite_ht,
		  	:prix_unite_ttc => @stock.produit_vente_libre.prix_unite_ttc,
	  	}
  	}
  	respond_to do |format|
  		format.json { render :json => @stock_produit_vente_libre }
  		format.html { render :show }
  	end
  end



  #________________ NEW ____________________________________________
  def new
    @stock = Stock.new
  	authorize! :update, User.find(params[:user_id]) #TRADUCTION : EST-IL AUTORISE A UPDATER CETTE UTILISATEUR ?
  end
  
  
  
  #________________ CREATE ____________________________________________  
  def create
    #_______ CONDITION CAN STOCK AR ______ 
  	if current_user.can_stock_ar
  	    @produit_autorise = ProduitAutorise.find(params[:stock][:produit_autorise_id])
  	    @stock = Stock.new(params[:stock])
  	    @stock.titre = @produit_autorise.titre
  	    @stock.description = @produit_autorise.description
  	    @stock.categorie_id =  @produit_autorise.categorie_id
  	elsif current_user.can_stock_sr
	  	@stock = Stock.new(params[:stock])
	end
	
	
	@stock.user_id = current_user.id
	  	
	if @stock.save
	  	flash[:notice] = "Produit ajoute a votre stock"
	  	redirect_to administration_user_stock_path(params[:user_id],@stock)
	else
		render 'new'
	end

  end
  
  
  
  #________________ EDIT ____________________________________________
  def edit
    @stock = Stock.find(params[:id])
  	authorize! :update, User.find(params[:user_id]) #TRADUCTION : EST-IL AUTORISE A UPDATER CETTE UTILISATEUR ?
  end
  
  
   
  
  #________________ UPDATE ____________________________________________  
  def update
  
   @stock = Stock.find(params[:id])
   
   
   #A VOIR POUR CETTE CONDITION
   if current_user.can_stock_ar && !params[:stock][:produit_autorise_id].nil?
  	    @produit_autorise = ProduitAutorise.find(params[:stock][:produit_autorise_id])

  	    @stock.titre = @produit_autorise.titre
  	    @stock.description = @produit_autorise.description
  	    @stock.categorie_id =  @produit_autorise.categorie_id
  	elsif current_user.can_stock_sr
	  	
	end
	
	@stock.user_id = current_user.id
	
	
   if @stock.update_attributes(params[:stock])
  		flash[:notice] = 'Stock modifie'
		redirect_to administration_user_stock_path(params[:user_id],@stock)
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'edit'
  	end
  end
  
  
  #________________ EXIST DEJA ________________________________________
  def alreadyExistStock
  	existe_deja = true
  	produit_stock = Stock.where("produit_autorise_id = ? AND user_id = ?",params[:produit_autorise_id], params[:user_id])
  	if produit_stock.count > 0 and params[:produit_autorise_id] != ""
  		existe_deja = true
  	else
  		existe_deja = false
  	end
  	
  	respond_to do |format|
  		format.json { render :json => existe_deja }
  		format.html { render :show }
  	end
  end
  
  
  
  
   #____________________________________________________________________________________
  #____________________________________________________________________________________
  #__________________________________ IMAGE ___________________________________________
  #____________________________________________________________________________________
  #____________________________________________________________________________________
  
  #_________________________________ ADD IMAGE _______________________________________
  def add_image
    @stock = Stock.find(params[:stock_id])
    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
	if params[:photo_stock][:first_image] == "1"
		@photo_first_image = PhotoStock.where('stock_id = ? AND first_image = "1"', @stock.id)
		if @photo_first_image.count > 0
			@photo_first_image[0].first_image = 0
			@photo_first_image[0].save	
		end
	else
		@photo_first_image = PhotoStock.where('stock_id = ? AND first_image = "1"', @stock.id)
		#__ SI PAS ENCORE DIMAGE PAR DEFAUT, ON L'APPLIQUE __
		if @photo_first_image.count == 0
			params[:photo_stock][:first_image] = "1"
		end
	end
	@photo_stock = PhotoStock.new
	@photo_stock.stock_id = @stock.id
	@photo_stock.update_attributes(params[:photo_stock])
	redirect_to [:administration,current_user,@stock]
  end
  
  
  #_________________________________ UPDATE  IMAGE _______________________________________
  def update_image
    @stock = Stock.find(params[:stock_id])
    @image = PhotoStock.find(params[:image_id])
    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
	if params[:photo_stock][:first_image] == "1"
		#___ SI PAS DE CHANGEMENT ______
		if @image.first_image == 1
			flash[:notice] = "Aucun changement"
		else
			@photo_first_image = PhotoStock.where('stock_id = ? AND first_image = "1"', @stock.id)
			if @photo_first_image.count > 0
				@photo_first_image[0].first_image = 0
				@photo_first_image[0].save	
			end
			@image.first_image = params[:photo_stock][:first_image]
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
	redirect_to [:administration,current_user,@stock]
  end
  
  #____________________________ DELETE IMAGE _________________________________________________
  def delete_image
  	@image_stock = PhotoStock.find(params[:image_id])
  	@image_stock.remove_image = true
  	@image_stock.destroy
  end



end
