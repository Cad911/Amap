class PageProduitController < ApplicationController
  layout "front"
  
  #____ LISTING TOUS LES PRODUITS ________
  def index
  	@titre = "Tous les produits"
  	@produits = ProduitVenteLibre.all
  end

  #____ AFFICHAGE PAGE PRODUIT _______
  def show
   @produit = ProduitVenteLibre.find(params[:product_id])
   #PRODUIT APPARTENANT A L'AGRICULTEUR
   @other_produits = ProduitVenteLibre.where("user_id=? AND id != ?",@produit.user_id, @produit.id)
  end
  
  #_____ LISTING PAR REVENDEUR / AGRICULTEUR ________
  def index_by_revendeur
  	@user = User.find(params[:user_id])
  	@titre = "Produit de l'agriculteur #{@user.nom}"
  	@produits = ProduitVenteLibre.where(:user_id => params[:user_id])
  	render :index
  end
  
  #__ LISTING PAR DIRECTION / AMAP _________
  def index_by_directeur
  	@direction = User.find(params[:direction_id])
  	@titre = "Produit de l'amap #{@direction.nom}"
  	@vendeur = User.where(:direction_id => params[:direction_id])
  	@produits = []
  	@vendeur.each do |vendeur|
  		@produit_vendeur = ProduitVenteLibre.where(:user_id =>vendeur.id)
  		@produit_vendeur.each do |produit|
  			@produits << produit
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
  	
	  	@titre = "Produit de la categorie : #{@categorie.nom}"
	    @stocks = Stock.where(:categorie_id => params[:categorie_id])
	    @produits = []
	    #__ SI STOCK A CATEGORIE
	    if @stocks.count != 0
	    	@stocks.each do |stock|
	    		@produit_vente_libre = ProduitVenteLibre.where(:stock_id => stock.id)
	    		#__ SI PRODUIT EST EN VENTE LIBRE
	    		if @produit_vente_libre.count != 0
	    			@produit_vente_libre.each do |produit|
	    				@produits << produit	
	    			end
	    		end   	
	    	end
	    end
	end
    
    render :index
  end
  
end
