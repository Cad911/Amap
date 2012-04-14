class ProcessOrderController < ApplicationController
  layout 'front'
  #_________________________________________________________________ RESUME DU PANIER ____________________________________________________________________
  def resume
  	
  	if current_client.nil?
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND session_id = ?', session[:abonnement_id])
  	else
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND client_id = ?', current_client.id)
  	end
  	@listing_produit = nil
  	@abonnement_panier = nil
  	if @abonnement_exist.count > 0
  		@titre = "Resume abonnement"
  		@abonnement_panier = Abonnement.find(@abonnement_exist[0].id)
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
  		
  		if @cageot_exist.count > 0
  			@cageot_ = Cageot.find(@cageot_exist[0].id)
  			@rel_cageot = RelCageotProduit.where(:cageot_id => @cageot_.id)
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
  	@point_relais = PointRelai.all #__ ACHANGER PEUT ETRE
	#___________ METTRE DEVISE DANS LA PAGE (LE FORMULAIRE D'IDENTIFICATION ______
  end

  def paiement
  end
end
