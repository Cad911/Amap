class PageProduitController < ApplicationController
  layout "front"
  #add_breadcrumb('Produits','/page_produit/index')
  
  def breadcrumb
  	super
  	@tab_breadcrumb.push({:path => page_produit_index_path, :title => 'Produit'})
  end
  
  #__________________________________________________________ LISTING TOUS LES PRODUITS ____________________________________________
  def index
  	@all_categorie = Categorie.all
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
   
   #__FIL D'ARIANNE__
   @tab_breadcrumb.push({:path => page_produit_show_path(@produit.user_id,params[:product_id]), :title => @produit.titre})
  end
  
  #________________________________ LISTING PAR REVENDEUR / AGRICULTEUR _____________________________________________________
  def index_by_revendeur
  	@user = User.find(params[:user_id])
  	@titre = "Produit de l'agriculteur #{@user.nom}"
  	@produits = ProduitVenteLibre.where(:user_id => params[:user_id])
  	
  	#__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_produit_index_by_revendeur_path(params[:user_id]), :title => 'Produits de '+@user.prenom})
    #_________________
    
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
  	
  	#__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_produit_index_by_directeur_path(params[:direction_id]), :title => 'Produits de l\'amap '+@direction.nom})
    #_________________
    
    
  	render :index
  end
  
  #_________________________________________________________ LISTING BY CATEGORIE _______________________________________________
  def index_by_categorie
  	
  	if !params[:categorie_id].kind_of?(Array) && !params[:categorie_id].nil? && params[:categorie_id] != ""
  		begin
  			@categorie = Categorie.find(params[:categorie_id])
  		rescue
  			@categorie = nil
  		end
  	else
  		@categorie = nil
  	end
  	
  	@all_categorie = Categorie.all
	
	if params[:categorie_id].kind_of?(Array) && (params[:categorie_id].nil? || params[:categorie_id] == "")
  		@titre = "Toutes les  categories"
  		@stocks = Stock.all
  	else
  		if @categorie.nil? && !params[:categorie_id].kind_of?(Array)
  			@titre = "Toutes les  categories"
  			@stocks = Stock.all
  		else
  			if !params[:categorie_id].kind_of?(Array)
  				@titre = "Produit de la categorie : #{@categorie.nom}"
  			end 
  			
  			@stocks = Stock.where(:categorie_id => params[:categorie_id])
  		end
    end

    
    @produits = Array.[]
    @produits_first_block = Array.[]
	@produit_middle_block = Array.[]
	@produit_last_block = Array.[]
    #__ SI STOCK A CATEGORIE
    if @stocks.count != 0
    	@stocks.each do |stock|
    		@produit_vente_libre = ProduitVenteLibre.where(:stock_id => stock.id)
    		#__ SI PRODUIT EST EN VENTE LIBRE
    		if @produit_vente_libre.count != 0
    			@produit_vente_libre.each do |produit|
    				@produits << produit	
    			end
    			
    			# @produits_first_block = Array.[]
# 				  	@produit_middle_block = Array.[]
# 				  	@produit_last_block = Array.[]
			  	
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
    
    if !params[:categorie_id].kind_of?(Array) && !params[:categorie_id].nil? && params[:categorie_id] != "" && @categorie != nil
	    #__FIL D'ARIANNE__
	   	@tab_breadcrumb.push({:path => page_produit_index_by_directeur_path(params[:categorie_id]), :title => @categorie.nom})
	    #_________________
	else
	
	end
    
    respond_to do |format|
  		format.json { render :partial => "list", :locals => { 
  			#render :json => {
  				:produits => @produits, 
  				:produits_first_block => @produits_first_block,
  				:first_huge_product =>  @first_huge_product,
  				:produit_middle_block => @produit_middle_block,
  				:produit_last_block => @produit_last_block,
  				:last_huge_product => @last_huge_product	
  				}
  		}
  		format.html { render :index }
  	end
  end
  
  
  
  #____________________ PRODUIT VENTE LIBRE WHERE PARAMS FILTER _________________________________
  def product_filter
      produit_vente = ProduitVenteLibre.all
      product_return = []
      
      
      
      produit_vente.each do |produit|
          condition_respect = true
          if params[:user_id] != nil and params[:user_id].to_i != produit.stock.user_id
              condition_respect = false
          end
          
          if condition_respect == true
              tab_produit = {
              			:id => produit.id,
                        :user_id => produit.stock.user_id,
              			:titre => produit.titre, 
              			:description => produit.description, 
              			:default_image => produit.stock.default_image, 
              			:prix_unite_ttc => produit.prix_unite_ttc,
              			:unite_mesure => produit.stock.unite_mesure.nom,
              }
              product_return << tab_produit 
          end
      end
      
      respond_to do |format|
	  	format.js do 
	  	     render :json => product_return.to_json
	  	end
	  	format.html {flash[:notice] = "Produit ajoute et Stock mis a jour en consequence"
	  		redirect_to [:administration,User.find(params[:user_id]),@produit_vente_libre] }
	  end
  end
  
end
