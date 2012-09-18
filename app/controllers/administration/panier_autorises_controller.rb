class Administration::PanierAutorisesController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID

#________________ INDEX ____________________________________________
  def index
  	@panier_autorises = PanierAutorise.where(:user_id => params[:user_id])
    authorize! :manage, User.find(params[:user_id]) #AUTORISATION POUR LA PRODUITS
  end
 
#__________________ SHOW __________________________________________
  def show
  	@panier_autorise = PanierAutorise.find(params[:id])
  	
  	respond_to do |format|
  		format.json { render :json => @panier_autorise }
  		format.html { render :show }
  	end
  end
#________________ CREATE ____________________________________________
  def create
  	@panier_autorise = PanierAutorise.new(params[:panier_autorise])
  	@panier_autorise.user_id = current_user.id
  	
  	if @panier_autorise.save
  		flash[:notice] = 'Produit autorise ajoute'
		redirect_to administration_user_panier_autorise_path(params[:user_id],@panier_autorise)	  	 		
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'new'
  	end
  end
  
#_________________ UPDATE ______________________________________________
  def update
  	if @panier_autorise.update_attributes(params[:panier_autorise])
  		flash[:notice] = 'Panier autorise modifie'
		redirect_to administration_user_panier_autorise_path(params[:user_id],@panier_autorise)
  	else
  		flash[:notice] = 'Une erreur est survenu, veuillez ressayer'
  		render 'edit'
  	end
  
  end

end
