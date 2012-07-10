class Administration::ProduitVenteLibresController < InheritedResources::Base
  load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID

  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ INDEX ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def index
  	@produit_vente_libres = ProduitVenteLibre.where(:user_id => params[:user_id])
  	authorize! :update, User.find(params[:user_id])
  end
  #_________________________________________________________________
  
  
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ SHOW ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def show
  	@produit_vente_libre = ProduitVenteLibre.find(params[:id])
  	@stock = Stock.find(@produit_vente_libre.stock.id)
  	@unite_mesure = UniteMesure.find(@stock.unite_mesure.id)
  	respond_to do |format|
  		format.json { render :json => {
  						:produit_vente_libre => @produit_vente_libre,
  						:stock => @stock,
  						:unite_mesure => @unite_mesure
  					} 	
  		}
  		format.html { render :show }
  	end
  end
  #_________________________________________________________________
  
  
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ NEW ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def new
    @produit_vente_libre = ProduitVenteLibre.new
    respond_to do |format|
  		format.js { render "new_ajax", :layout => false }
  		format.html { render :new }
  	end
  	authorize! :update, User.find(params[:user_id]) #TRADUCTION : EST-IL AUTORISE A UPDATER CETTE UTILISATEUR ?
  end
  #_________________________________________________________________
  
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ EDIT ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def edit
  @produit_vente_libre = ProduitVenteLibre.find(params[:id])
  respond_to do |format|
  		format.js { render "edit_ajax", :layout => false }
  		format.html { render :new }
  	end
  end
  
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ CREATE ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
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
  
  
  
  
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ ONE PRODUCT DEJA EN VENTE ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def oneDejaEnVente
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
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ ALL PRODUCT DEJA EN VENTE BY USER ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________ 
  def allDejaEnVente
  	all_deja_vente = true
  	stock_id = 0
  	
  	stock_user = Stock.where("user_id = ?", params[:user_id])
  	produit_vente = ProduitVenteLibre.where("user_id = ?", params[:user_id])
  	
  	stock_user.each do |stock_u|
  	    deja_vente = false
  		
  		produit_vente.each do |produit_u|
  			if stock_u.id == produit_u.stock_id
  			    deja_vente = true
  			else
  			    stock_id = stock_u.id
  			end
  		end
  		
  		if deja_vente == false
  		    #ARRETER LA BOUCLE POUR DIRE QUE C'EST OK
  		    all_deja_vente = false
  		    break
  		end
  	end
  	
  	respond_to do |format|
  		format.json { render :json => {
	  		:all_deja_vente => all_deja_vente,
	  		:stock_id => stock_id	
  		}}
  		format.html { render :show }
  	end
  end
  #_________________________________________________________________
  
  

    
end
