class Administration::ProduitAutorisesController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID

  #________________ INDEX ____________________________________________
  def index
  	@produit_autorises = ProduitAutorise.where(:user_id => params[:user_id])
    authorize! :manage, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
  end
  
  
  #__________________ SHOW __________________________________________
  def show
  	@produit_autorise = ProduitAutorise.find(params[:id])
  	
  	respond_to do |format|
  		format.json { render :json => @produit_autorise }
  		format.html { render :show }
  	end
  end
  
  
  #________________ CREATE ____________________________________________
  def create
  	@produit_autorise = ProduitAutorise.new(params[:produit_autorise])
  	@produit_autorise.user_id = current_user.id
  	
  	if @produit_autorise.save
  		flash[:notice] = 'Produit autorise ajoute'
		redirect_to administration_user_produit_autorise_path(params[:user_id],@produit_autorise)	  	 		
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'new'
  	end
  end
  
  
  
  #_________________ UPDATE ______________________________________________  
  def update
  	if @produit_autorise.update_attributes(params[:produit_autorise])
  		flash[:notice] = 'Produit autorise modifie'
		redirect_to administration_user_produit_autorise_path(params[:user_id],@produit_autorise)
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'edit'
  	end
  
  end  
end
