class PageRevendeurController < ApplicationController
  layout "front"
  
  def breadcrumb
  	super
  	@tab_breadcrumb.push({:path => page_revendeur_index_path, :title => 'Agriculteur'})
  end
  
  def index
  	@titre = "Tous les agriculteurs"
  	@revendeurs = User.where(:entite_id => "2") #Le 2 correspond au agrciulteurs
  	
  end

  def show
  	@revendeur = User.find(params[:id])
  	
  	#__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_revendeur_show_path(params[:id]), :title => @revendeur.prenom})
    #_________________
  end
  
  def index_by_direction
  	@direction = User.find(params[:direction_id])
  	@titre = "Liste des agriculteurs de l'amap #{@direction.nom}"
  	@revendeurs = User.where("entite_id = '2' AND direction_id = ?", params[:direction_id]) #Le 2 correspond au agrciulteurs
  	
  	#__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_revendeur_index_by_direction_path(params[:direction_id]), :title => 'Amap '+@direction.prenom})
    #_________________
    
  	render :index
  end
end
