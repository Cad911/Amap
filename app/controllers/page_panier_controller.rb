class PagePanierController < ApplicationController
   layout "front"
  
  def breadcrumb
  	super
  	@tab_breadcrumb.push({:path => page_panier_index_path, :title => 'Panier'})
  end
  
  
  
  
  #__________________________________________________________ LISTING TOUS LES PANIERS ____________________________________________
  def index
  	@titre = "Tous les paniers"
  	@paniers = Panier.all
  	@paniers_first_block = []
  	@paniers_middle_block = []
  	@paniers_last_block = []
  	
  	#___ SI MOINS DE 5 PRODUIT, QUE LE BLOCK DU MILIEU _____
  	if @paniers.count < 5
  		@paniers_middle_block = @paniers
  	#___ SI 5 PRODUITS, SEULEMENT LE PREMIER BLOCK _________
  	elsif @paniers.count == 5
  		@first_huge_panier = @paniers[0]
  		(1..4).each do |i|
  			@paniers_first_block << @paniers[i]
  		end
  	#___________ SI PLUS DE 5 PRODUITS _____________________
  	elsif 5 < @paniers.count
  		#______ PREMIER BLOCK ___________
  		@first_huge_panier = @paniers[0]
  		(1..4).each do |i|
  			@paniers_first_block << @paniers[i]
  		end
  		
  		#_______ SI ON A LE COMPTE PILE POUR AVOIR LE FIRST BLOCK, MIDDLE BLOCK AND LAST BLOCK
  		if (@paniers.count - 10) % 4 == 0 && @paniers.count - 10 >= 0
	  		(5..@paniers.count-6).each do |i|
	  			@paniers_middle_block << @paniers[i]
	  		end
		 
	  		(@paniers.count-5..@paniers.count-2).each do |i|
	  			@paniers_last_block << @paniers[i]
	  		end
	  		@last_huge_panier = @paniers[@paniers.count-1]
	  	#_____ PAS DE LAST BLOCK ___________
  		else
  			(5..@paniers.count-1).each do |i|
	  			@paniers_middle_block << @paniers[i]
	  		end
  		end
  	end
  end

  
  #_________________________________________________________ LISTING BY CATEGORIE _______________________________________________
  def index_by_categorie
  	@categorie = Categorie.find(params[:categorie_id])
  	if @categorie.nil?
  		@titre = "Cette categorie n'existe pas"
  	else
  	
	  	@titre = "Produit de la categorie : #{@categorie.nom}"
	    @paniers = Panier.where(:categorie_id => params[:categorie_id])
	    @produits = []
	    
	    #___ SI MOINS DE 5 PRODUIT, QUE LE BLOCK DU MILIEU _____
	  	if @paniers.count < 5
	  		@paniers_middle_block = @paniers
	  	#___ SI 5 PRODUITS, SEULEMENT LE PREMIER BLOCK _________
	  	elsif @paniers.count == 5
	  		@first_huge_panier = @paniers[0]
	  		(1..4).each do |i|
	  			@paniers_first_block << @paniers[i]
	  		end
	  	#___________ SI PLUS DE 5 PRODUITS _____________________
	  	elsif 5 < @paniers.count
	  		#______ PREMIER BLOCK ___________
	  		@first_huge_panier = @paniers[0]
	  		(1..4).each do |i|
	  			@paniers_first_block << @paniers[i]
	  		end
	  		
	  		#_______ SI ON A LE COMPTE PILE POUR AVOIR LE FIRST BLOCK, MIDDLE BLOCK AND LAST BLOCK
	  		if (@paniers.count - 10) % 4 == 0 && @paniers.count - 10 >= 0
		  		(5..@paniers.count-6).each do |i|
		  			@paniers_middle_block << @paniers[i]
		  		end
			 
		  		(@paniers.count-5..@paniers.count-2).each do |i|
		  			@paniers_last_block << @paniers[i]
		  		end
		  		@last_huge_panier = @paniers[@paniers.count-1]
		  	#_____ PAS DE LAST BLOCK ___________
	  		else
	  			(5..@paniers.count-1).each do |i|
		  			@panier_middle_block << @paniers[i]
		  		end
	  		end
	  	end
	end
	
	#__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_panier_index_by_categorie_path(params[:categorie_id]), :title => @categorie.nom})
    #_________________
    
    render :index
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  #____ AFFICHAGE PAGE PRODUIT _______
  def show
   @panier = Panier.find(params[:panier_id])
   #PRODUIT APPARTENANT A L'AGRICULTEUR
   @other_paniers = Panier.where("revendeur_id=? AND id != ?",@panier.revendeur_id, @panier.id)
   
   #__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_panier_show_path(@panier.revendeur_id,params[:panier_id]), :title => @panier.titre})
   #_________________
    
  end
  
  #_____ LISTING PAR REVENDEUR / AGRICULTEUR ________
  def index_by_revendeur
  	@user = User.find(params[:user_id])
  	@titre = "Panier de l'agriculteur #{@user.nom}"
  	@paniers = Panier.where(:revendeur_id => params[:user_id])
  	
    #__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_panier_index_by_revendeur_path(params[:user_id]), :title => @user.prenom})
    #_________________
   
   
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
  	
  	 #__FIL D'ARIANNE__
   	@tab_breadcrumb.push({:path => page_panier_index_by_directeur_path(params[:direction_id]), :title => 'Amap '+@direction.nom})
    #_________________
    
    
  	render :index
  end
  
  
  #____________________PANIER EN VENTE WHERE PARAMS FILTER _________________________________
  def basket_filter
      panier_vente = Panier.all
      panier_return = []
      
      
      
      panier_vente.each do |panier|
          condition_respect = true
          if params[:user_id] != nil and params[:user_id].to_i != panier.revendeur_id
              condition_respect = false
          end
          
          if condition_respect
              tab_panier = {
              			:id => panier.id,
                        :user_id => panier.revendeur_id,
              			:titre => panier.titre, 
              			:description => panier.description, 
              			:default_image => '', 
              			:prix_unite_ttc => panier.prix_unite_ttc,
              			:nb_personne => panier.nombre_personne,
              }
              panier_return << tab_panier 
          end
      end
      
      respond_to do |format|
	  	format.js do 
	  	     render :json => panier_return.to_json
	  	end
	  end
  end

end
