class PageRevendeurController < ApplicationController
  layout "front"
  
  def index
  	@titre = "Tous les agriculteurs"
  	@revendeurs = User.where(:entite_id => "2") #Le 2 correspond au agrciulteurs
  end

  def show
  	@revendeur = User.find(params[:id])
  end
  
  def index_by_direction
  	@direction = User.find(params[:direction_id])
  	@titre = "Liste des agriculteurs de l'amap #{@direction.nom}"
  	@revendeurs = User.where("entite_id = '2' AND direction_id = ?", params[:direction_id]) #Le 2 correspond au agrciulteurs
  	render :index
  end
end
