class Administration::StatistiquesController < ApplicationController
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #________________ CA PRODUCT SELL BY MONTH ____________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  #_________________________________________________________________
  def CAProductSellThisMonth
	    date = Date.today
	  	all_commande_month = Commande.where('etat = "paye" AND MONTH(updated_at) = ? AND YEAR(updated_at) = ?',date.month, date.year)
	  	all_abonnement_month = Abonnement.where('etat = "paye" AND MONTH(updated_at) = ? AND YEAR(updated_at) = ?',date.month, date.year)
	  	@CA = { :CA_product_ttc => 0,:CA_product_ht => 0,:CA_abonnement_ttc => 0,:CA_abonnement_ht => 0, :CA_total_ttc => 0, :CA_total_ht => 0 }
	  	
	  	all_commande_month.each do |commande|
	  		(commande.rel_commande_produits).each do |produit_commande|
	  			if produit_commande.user_id == current_user.id
	  			    @CA[:CA_product_ttc] += produit_commande.nb_pack * produit_commande.prix_unite_ttc
	  			    @CA[:CA_product_ht] += produit_commande.nb_pack * produit_commande.prix_unite_ht
	  			    
	  			    @CA[:CA_total_ttc] += produit_commande.nb_pack * produit_commande.prix_unite_ttc
	  			    @CA[:CA_total_ht] += produit_commande.nb_pack * produit_commande.prix_unite_ht
	  			end
	  		end
	  	end
	  	
	  	all_abonnement_month.each do |abonnement|
		  	if abonnement.panier.user.id == current_user.id
			  	@CA[:CA_abonnement_ttc] += abonnement.prix_ttc
	  	        @CA[:CA_abonnement_ht] += abonnement.prix_ht
	  	        
	  	        @CA[:CA_total_ttc] += abonnement.prix_ttc
	  			@CA[:CA_total_ht] += abonnement.prix_ht
		  	end
	  	end
	  	
	  	respond_to do |format|
	  		format.json { render :json => @CA }
	  		format.html { render :nothing }
	  	end
  end
  
  
    def CAProductSellThisYear
	    date = Date.today
	  	all_commande_month = Commande.where('etat = "paye" AND YEAR(updated_at) = ?', date.year)
	  	all_abonnement_month = Abonnement.where('etat = "paye" AND YEAR(updated_at) = ?', date.year)
	  	@CA_by_month = {}
	  	@CA_incrementer_by_month = {}
	  	@CA_total = { :CA_product_ttc => 0,:CA_product_ht => 0,:CA_abonnement_ttc => 0,:CA_abonnement_ht => 0 }
	  	(1..12).each do |month|
	  		@CA_by_month[month] = {:CA_product_ttc => 0,:CA_product_ht => 0,:CA_abonnement_ttc => 0,:CA_abonnement_ht => 0}
	  		#@CA_incrementer_by_month[month] = {:CA_product_ttc => 0,:CA_product_ht => 0,:CA_abonnement_ttc => 0,:CA_abonnement_ht => 0}

	  	end
	  	
	  	all_commande_month.each do |commande|
	  		(commande.rel_commande_produits).each do |produit_commande|
	  			if produit_commande.user_id == current_user.id
	  			    month_commande = (commande.updated_at).month
	  			    @CA_by_month[month_commande][:CA_product_ttc] += produit_commande.nb_pack * produit_commande.prix_unite_ttc
	  			    @CA_by_month[month_commande][:CA_product_ht] += produit_commande.nb_pack * produit_commande.prix_unite_ht
	  			end
	  		end
	  	end
	  	
	  	all_abonnement_month.each do |abonnement|
		  	if abonnement.panier.user.id == current_user.id
		  	    month_abonnnement = (abonnement.updated_at).month
			  	@CA_by_month[month_abonnnement][:CA_abonnement_ttc] += abonnement.prix_ttc
	  	        @CA_by_month[month_abonnnement][:CA_abonnement_ht] += abonnement.prix_ht
		  	end
	  	end
	  	
	  	(1..12).each do |month|
	  		if month > 1
	  			@CA_incrementer_by_month[month] = {
	  				:CA_product_ttc => @CA_by_month[month][:CA_product_ttc] + @CA_incrementer_by_month[month - 1][:CA_product_ttc],
	  				:CA_product_ht => @CA_by_month[month][:CA_product_ht] + @CA_incrementer_by_month[month - 1][:CA_product_ht],
	  				:CA_abonnement_ttc => @CA_by_month[month][:CA_abonnement_ttc] + @CA_incrementer_by_month[month - 1][:CA_abonnement_ttc],
	  				:CA_abonnement_ht => @CA_by_month[month][:CA_abonnement_ht] + @CA_incrementer_by_month[month - 1][:CA_abonnement_ht]
	  			}
	  		else
	  			@CA_incrementer_by_month[month] = {
	  				:CA_product_ttc => @CA_by_month[month][:CA_product_ttc],
	  				:CA_product_ht => @CA_by_month[month][:CA_product_ht],
	  				:CA_abonnement_ttc => @CA_by_month[month][:CA_abonnement_ttc],
	  				:CA_abonnement_ht => @CA_by_month[month][:CA_abonnement_ht],
	  			}
	  		end
	  	end
	  	respond_to do |format|
	  		format.json { render :json => {:CA_by_month => @CA_by_month, :CA_increment => @CA_incrementer_by_month} }
	  		format.html { render :nothing }
	  	end
  end
  
  
end

