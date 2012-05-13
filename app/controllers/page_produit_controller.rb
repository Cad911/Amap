class PageProduitController < ApplicationController
  layout "front"
  
  #__________________________________________________________ LISTING TOUS LES PRODUITS ____________________________________________
  def index
  	@titre = "Tous les produits"
  	@produits = ProduitVenteLibre.all
  	@produits_first_block = []
  	@produit_middle_block = []
  	@produit_last_block = []
  	
  	#___ SI MOINS DE 5 PRODUIT, QUE LE BLOCK DU MILIEU _____
  	if @produits.count < 5
  		@produit_middle_block = @produits
  	#___ SI 5 PRODUITS, SEULEMENT LE PREMIER BLOCK _________
  	elsif @produits.count == 5
  		@first_huge_product = @produits[0]
  		(1..4).each do |i|
  			@produits_first_block << @produits[i]
  		end
  	#___________ SI PLUS DE 5 PRODUITS _____________________
  	elsif 5 < @produits.count
  		#______ PREMIER BLOCK ___________
  		@first_huge_product = @produits[0]
  		(1..4).each do |i|
  			@produits_first_block << @produits[i]
  		end
  		
  		#_______ SI ON A LE COMPTE PILE POUR AVOIR LE FIRST BLOCK, MIDDLE BLOCK AND LAST BLOCK
  		if (@produits.count - 10) % 4 == 0 && @produits.count - 10 >= 0
	  		(5..@produits.count-6).each do |i|
	  			@produit_middle_block << @produits[i]
	  		end
		 
	  		(@produits.count-5..@produits.count-2).each do |i|
	  			@produit_last_block << @produits[i]
	  		end
	  		@last_huge_product = @produits[@produits.count-1]
	  	#_____ PAS DE LAST BLOCK ___________
  		else
  			(5..@produits.count-1).each do |i|
	  			@produit_middle_block << @produits[i]
	  		end
  		end
  	end
  end

  #________________________________________ AFFICHAGE PAGE PRODUIT ____________________________________________________
  def show
   @produit = ProduitVenteLibre.find(params[:product_id])
   #PRODUIT APPARTENANT A L'AGRICULTEUR
   @other_produits = ProduitVenteLibre.where("user_id=? AND id != ?",@produit.user_id, @produit.id)
  end
  
  #________________________________ LISTING PAR REVENDEUR / AGRICULTEUR _____________________________________________________
  def index_by_revendeur
  	@user = User.find(params[:user_id])
  	@titre = "Produit de l'agriculteur #{@user.nom}"
  	@produits = ProduitVenteLibre.where(:user_id => params[:user_id])
  	render :index
  end
  
  #_______________________________________________ LISTING PAR DIRECTION / AMAP _____________________________________________
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
  
  #_________________________________________________________ LISTING BY CATEGORIE _______________________________________________
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
	    			
	    			@produits_first_block = []
				  	@produit_middle_block = []
				  	@produit_last_block = []
				  	
				  	if @produits.count < 5
				  		@produit_middle_block = @produits
				  	elsif @produits.count == 5
				  		@first_huge_product = @produits[0]
				  		(1..4).each do |i|
				  			@produits_first_block << @produits[i]
				  		end
				  	elsif 5 < @produits.count
				  		@first_huge_product = @produits[0]
				  		(1..4).each do |i|
				  			@produits_first_block << @produits[i]
				  		end
				  		
				  		if (@produits.count - 10) % 4 == 0 && @produits.count - 10 >= 0
					  		(5..@produits.count-6).each do |i|
					  			@produit_middle_block << @produits[i]
					  		end
						 
					  		(@produits.count-5..@produits.count-2).each do |i|
					  			@produit_last_block << @produits[i]
					  		end
					  		@last_huge_product = @produits[@produits.count-1] 
				  		else
				  			(5..@produits.count-1).each do |i|
					  			@produit_middle_block << @produits[i]
					  		end
				  		end
				  	end

	    		end   	
	    	end
	    end
	end
    
    render :index
  end
  
end
