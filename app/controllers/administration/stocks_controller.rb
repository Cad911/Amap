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
  	respond_to do |format|
  		format.json { render :json => [@stock,@unite_mesure] }
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
   
   if current_user.can_stock_ar
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

end
