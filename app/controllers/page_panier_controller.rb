class PagePanierController < ApplicationController
   layout "front"
  
  #____ LISTING TOUS LES PANIERS ________
  def index
  	@titre = "Tous les paniers"
  	@paniers = Panier.all
  end

  #____ AFFICHAGE PAGE PRODUIT _______
  def show
   @panier = Panier.find(params[:panier_id])
   #PRODUIT APPARTENANT A L'AGRICULTEUR
   @other_paniers = Panier.where("revendeur_id=? AND id != ?",@panier.revendeur_id, @panier.id)
  end
  
  #_____ LISTING PAR REVENDEUR / AGRICULTEUR ________
  def index_by_revendeur
  	@user = User.find(params[:user_id])
  	@titre = "Panier de l'agriculteur #{@user.nom}"
  	@paniers = Panier.where(:revendeur_id => params[:user_id])
  	render :index
  end
  
  #__ LISTING PAR DIRECTION / AMAP _________
  def index_by_directeur
  	@direction = User.find(params[:direction_id])
  	@titre = "Panier de l'amap #{@direction.nom}"
  	@vendeur = User.where(:direction_id => params[:direction_id])
  	@paniers = []
  	@vendeur.each do |vendeur|
  		@panier_vendeur = Panier.where(:revendeur_id =>vendeur.id)
  		@panier_vendeur.each do |produit|
  			@paniers << produit
  		end
  	end
  	render :index
  end
  
  #___ LISTING BY CATEGORIE __
  def index_by_categorie
  	@categorie = Categorie.find(params[:categorie_id])
  	if @categorie.nil?
  		@titre = "Cette categorie n'existe pas"
  	else
  	
	  	@titre = "Panier de la categorie : #{@categorie.nom}"
	    @paniers = Panier.where(:categorie_id => params[:categorie_id])
	end
    
    render :index
  end

end
