class Administration::ProduitVenteLibresController < InheritedResources::Base
  load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID

  #________________ INDEX ____________________________________________
  def index
  	@produit_vente_libres = ProduitVenteLibre.where(:user_id => params[:user_id])
  	authorize! :update, User.find(params[:user_id])
  end
  #_________________________________________________________________
  
  
  #__________________ SHOW ________________________________________________
  def show
  	@produit_vente_libre = ProduitVenteLibre.find(params[:id])
  end
  #_________________________________________________________________
  
  
  #________________ NEW ____________________________________________
  def new
    @produit_vente_libre = ProduitVenteLibre.new
    respond_to do |format|
  		format.js { render "new_ajax", :layout => false }
  		format.html { render :new }
  	end
  	authorize! :update, User.find(params[:user_id]) #TRADUCTION : EST-IL AUTORISE A UPDATER CETTE UTILISATEUR ?
  end
  #_________________________________________________________________
  
  
  
  #_________________ CREATE _________________________________________
  def create
	  @produit_vente_libre = ProduitVenteLibre.new(params[:produit_vente_libre])
	  @stock_produit = Stock.find(params[:produit_vente_libre][:stock_id])
	  
	  @produit_vente_libre.titre = @stock_produit.titre
	  @produit_vente_libre.description = @stock_produit.description
	  @produit_vente_libre.user_id = params[:user_id]
	  
	  #@stock_produit.quantite -=  (@produit_vente_libre.nombre_pack * @produit_vente_libre.quantite) #ON CHANGE LA QUANTITE EN STOCK
	  
	  
	  if @produit_vente_libre.save #and @stock_produit.save 
	  	respond_to do |format|
	  		format.js { render :nothing => true}
	  		format.html {flash[:notice] = "Produit ajoute et Stock mis a jour en consequence"
	  				 redirect_to [:administration,User.find(params[:user_id]),@produit_vente_libre] }
	  	end
	  else
	  	flash[:notice] = "ERREUR"
	  	render 'new'
	  end
  end
  #_________________________________________________________________
  
  
  
  
  #_______________________ DEJA EN VENTE FOR JS _______________________________________
  def dejaEnVente
  	existe_deja = true
  	produit_vente = ProduitVenteLibre.where("stock_id = ? AND user_id = ?",params[:stock_id], params[:user_id])
  	
  	if produit_vente.count > 0 and params[:stock_id] != ""
  		existe_deja = true
  	else
  		existe_deja = false
  	end
  	
  	respond_to do |format|
  		format.json { render :json => existe_deja }
  		format.html { render :show }
  	end
  end
  #_________________________________________________________________
    
end
