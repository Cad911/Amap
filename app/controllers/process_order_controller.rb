class ProcessOrderController < ApplicationController
  layout 'front'
  
  #_________________________________________________________________ RESUME DU PANIER ____________________________________________________________________
  def resume
  	
  	#__ REGARDE SI ABONNEMENT 
  	if current_client.nil?
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND session_id = ?', session[:abonnement_id])
  	else
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND client_id = ?', current_client.id)
  	end
  	@listing_produit = nil
  	@abonnement_panier = nil
  	#__ SI ABONNEMENT EXISTE ___
  	if @abonnement_exist.count > 0
  		@titre = "Resume abonnement"
  		@abonnement_panier = Abonnement.find(@abonnement_exist[0].id)
  	#__ SI ABONNEMENT EXISTE PAS
  	else
  		@titre = "Resume cageot"
  		if !current_client.nil?
  			@cageot_exist = Cageot.where("etat = 'en_cours' AND client_id = ?", current_client.id)
  		else
  			if !session[:cageot_id].nil?
  				@cageot_exist = Cageot.where("etat = 'en_cours' AND session_id = ?", session[:cageot_id])
  			else
  				@cageot_exist = []
  			end
  		end
  		
  		#__ SI PANIER EXISTE _____
  		if @cageot_exist.count > 0
  			@cageot_ = Cageot.find(@cageot_exist[0].id)
  			@rel_cageot = RelCageotProduit.where(:cageot_id => @cageot_.id)
  			#____ SI PRODUIT DANS PANIER ____
  			if @rel_cageot.count > 0
  				@listing_produit = @rel_cageot
  				@total = 0
  				@rel_cageot.each do |p|
  					@total += (p.nombre_pack * p.produit_vente_libre.prix_unite_ttc)
  				end
  			end
  		end
  	end
  	
  	
  end

  #_______________________________ CONFIRMATION PANIER ET CHOIX POINT RELAI ET S'IDENTIFIER SI CE N'EST PAS LE CAS ___________________________________________
  def confirmation
   
    @has_cageot_or_abo = false 
    #__ REGARDE SI ABONNEMENT 
  	if current_client.nil?
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND session_id = ?', session[:abonnement_id])
  	else
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND client_id = ?', current_client.id)
  	end
  	@listing_produit = nil
  	@abonnement_panier = nil
  	#__ SI ABONNEMENT EXISTE ___
  	if @abonnement_exist.count > 0
  	    @has_cageot_or_abo = true
  		#__ @abonnement_panier = Abonnement.find(@abonnement_exist[0].id)
  	#__ SI ABONNEMENT EXISTE PAS
  	else
  		@titre = "Resume cageot"
  		if !current_client.nil?
  			@cageot_exist = Cageot.where("etat = 'en_cours' AND client_id = ?", current_client.id)
  		else
  			if !session[:cageot_id].nil?
  				@cageot_exist = Cageot.where("etat = 'en_cours' AND session_id = ?", session[:cageot_id])
  			else
  				@cageot_exist = []
  			end
  		end
  		
  		#__ SI PANIER EXISTE _____
  		if @cageot_exist.count > 0
  			@cageot_ = Cageot.find(@cageot_exist[0].id)
  			@rel_cageot = RelCageotProduit.where(:cageot_id => @cageot_.id)
  			#____ SI PRODUIT DANS PANIER ____
  			if @rel_cageot.count > 0
  			    @has_cageot_or_abo = true
  				@point_relais = PointRelai.all #__ ACHANGER PEUT ETRE
  			end
  		end
  	end
	
	#__ SI ABONNEMENT OU CAGEOT__
	if @has_cageot_or_abo
	   render :confirmation
	else
	   flash[:notice] = "Votre panier est vide"
	   redirect_to process_order_resume_path
	end
  end
  
  
  
  
  #_____________________________ ENREGISTREMENT DU POINT RELAIS ET CREATION FICHE COMMANDE __________________________________________________________________
  def selectPr
  	if params[:point_relai][:id] != ""
  		@cageot_encours = Cageot.where('etat = "en_cours" AND client_id = ?', current_client.id)
  		#_____ SI CAGEOT ACUTEL EXIST __________________________________________________________________
  		if @cageot_encours.count > 0
  			@cageot_ = Cageot.find(@cageot_encours[0].id)
  			@product_cageot = RelCageotProduit.where("cageot_id = ?", @cageot_.id)
  			total = 0
  			#__ CALCUL TOTAL __
  			@product_cageot.each do |product|
  				total += product.produit_vente_libre.prix_unite_ttc * product.nombre_pack
  			end
  			#_____ CREATION OU MISE A JOUR DE LA COMMANDE / VERIFICATION SI UNE COMMANDE N'EST PAS DEJA ASSOCIE AU CAGEOT ACTUEL ____________
  			@commande_exist = Commande.where("cageot_id = ? AND etat = 'en_cours'",  @cageot_.id )
  			if @commande_exist.count > 0
  				@commande = Commande.find(@commande_exist)
  				@commande.total = total
  			else
  				@commande = Commande.new
  				@commande.cageot_id = @cageot_.id
  				@commande.client_id = current_client.id
  				@commande.etat = 'en_cours'
  				
  				@commande.total = total
  			end
  			@commande.point_relai_id = params[:point_relai][:id]
  			@commande.save
  			
  			# _______ RATTACHEMENT DES PRODUITS A LA COMMANDE ______
  			@product_cageot.each do |product|
  					@rel_commande_produit_exist = RelCommandeProduit.where('commande_id = ? AND produit_vente_libre_id = ?', @commande.id, product.produit_vente_libre.id)
  					if @rel_commande_produit_exist.count > 0
  						@rel_commande_produit = RelCommandeProduit.find(@rel_commande_produit_exist[0].id)
  					else
  						@rel_commande_produit = RelCommandeProduit.new
  						@rel_commande_produit.commande_id = @commande.id
  						@rel_commande_produit.produit_vente_libre_id = product.produit_vente_libre.id
  					end
  					@rel_commande_produit.prix_unite_ht = product.produit_vente_libre.prix_unite_ht
  					@rel_commande_produit.prix_unite_ttc = product.produit_vente_libre.prix_unite_ttc
  					@rel_commande_produit.nb_pack = product.nombre_pack
  					@rel_commande_produit.quantite = product.produit_vente_libre.quantite
  					@rel_commande_produit.save
  			end
  		
  		
	  		#__________ VERIFICATION QUE TOUS LES PRODUITS RATTACHE A LA COMMANDE SONT DANS LE PANIER ______
	  		@all_product_commande = RelCommandeProduit.where('commande_id = ?', @commande.id)
	  		@all_product_commande.each do |product_commande|
	  			@in_cageot = false
	  			@product_cageot.each do |product|
	  				if product.produit_vente_libre.id == product_commande.produit_vente_libre_id
	  					@in_cageot = true
	  				end
	  			end
	  			if !@in_cageot
					product_commande.destroy
				end
	  		end
  		
  		end
  		
  		
  		#____________________________ SI ABONNEMENT __________________________________________________
  		@abonnement_encours = Abonnement.where("client_id = ? AND etat = 'en_cours'", current_client.id)
  		if @abonnement_encours.count >0
  		
  		end
  		redirect_to process_order_paiement_path
  	else
  		render :confirmation
  	end
  end


  #________________________________ PAGE PAIEMENT _____________________________________
  def paiement
  	@commande_apayer = Commande.where("client_id = ? AND etat = 'en_cours'", current_client.id)
  	#___ SI COMMANDE
  	if @commande_apayer.count > 0
  		@ma_commande = Commande.find(@commande_apayer[0].id)
  		@update_mes_produits_commandes  = RelCommandeProduit.where('commande_id = ?', @ma_commande.id)
  		#____ON MET A JOUR LES PRODUITS DE LA COMMANDE ET LE TOTAL DE LA COMMANDE _____
  		@product_cageot = RelCageotProduit.where('cageot_id = ?',@ma_commande.cageot_id)
  		total = 0
  		@product_cageot.each do |product|
  				total += product.produit_vente_libre.prix_unite_ttc * product.nombre_pack
  		end
  		@ma_commande.total = total
  		@ma_commande.save
  		@update_mes_produits_commandes.each do |produit_commande|
  			@produit_vente_libre = ProduitVenteLibre.find(produit_commande.produit_vente_libre_id)
  			produit_commande.prix_unite_ht = @produit_vente_libre.prix_unite_ht
  			produit_commande.prix_unite_ttc = @produit_vente_libre.prix_unite_ttc
  			produit_commande.quantite = @produit_vente_libre.quantite
  		end
  		@mes_produit_commande = RelCommandeProduit.where('commande_id = ?', @ma_commande)
  		@mon_point_relai = PointRelai.find(@ma_commande.point_relai.id)
  		
  	else
  		flash[:notice] = "Vous navez rien a payer"
  		redirect_to process_order_resume_path
  	end
    @mon_point_relai = PointRelai.find(@ma_commande.point_relai_id)
  end
  
  #______________________ ACTION DE PAYER LA COMMANDE ______________________________________________
  def payerCommande
  	@commande_apayer = Commande.where("client_id = ? AND etat = 'en_cours'", current_client.id)
  	if @commande_apayer.count > 0
  		#__UPDATE COMMANDE
  		@ma_commande_payer = Commande.find(@commande_apayer[0].id)
  		@ma_commande_payer.etat = "paye"
  		@ma_commande_payer.save
  		#__UPDATE CAGEOT
  		@cageot_valide = Cageot.find(@ma_commande_payer.cageot_id)
  		@cageot_valide.etat = "confirme"
  		@cageot_valide.save()
  		@produit_de_commande = RelCommandeProduit.where('commande_id = ?', @ma_commande_payer.id)
  		render "end_process"
  	else
  		flash[:notice] = "Une erreur est survenue, veuillez recommencer "
  		redirect_to process_order_resume_path
  	end
  end
  

end
