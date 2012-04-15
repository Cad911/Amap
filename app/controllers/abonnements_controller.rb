class AbonnementsController < InheritedResources::Base

  def sabonner
  	#__________________________#
  	#						   #
  	#  SI CLIENT PAS CONNECTER #
  	#						   #
  	#__________________________#
  	if current_client.nil?
  		#____ SI ABONNEMENT EXIST PAS ____
  		if session[:abonnement_id].nil?
  			session[:abonnement_id] = "#{DateTime.now.to_i}"+("#{(1..100).to_a.shuffle.join}#{('a'..'z').to_a.shuffle.join}").split('').shuffle.join #__ GENERATION ID POUR PANIER __
  		else
  			@abonnement_exist = Abonnement.where('etat = "en_cours" AND session_id = ?',session[:abonnement_id])
  			#____ SI ABONNEMENT EXIST __
  			if @abonnement_exist.count > 0
  				@abonnement_exist1 =  Abonnement.find(@abonnement_exist[0].id)
  				@abonnement_exist1.etat = "annule"
  				@abonnement_exist1.save
  			end
  		end
  		
  		#__ SUPPRESSION CAGEOT SI IL EXISTE
  		if !session[:panier_id].nil?
  			@cageot_exist = Cageot.where('etat = "en_cours" AND session_id = ?',session[:panier_id])
  			#____ SI ABONNEMENT EXIST __
  			if @cageot_exist.count > 0
  				@cageot =  Cageot.find(@cageot_exist[0].id)
  				@cageot.etat = "annule"
  				@cageot.save
  			end
  		end
		@date_debut = Date.current
	
  		@abonnement = Abonnement.new
  		@abonnement.session_id = session[:abonnement_id]
  		@abonnement.panier_id = params[:panier][:id]
  		@abonnement.duree = params[:panier][:duree].to_i #EN MOIS
  		@abonnement.etat = 'en_cours'
  		@abonnement.date_debut = @date_debut
  		@abonnement.date_fin = @date_debut.months_since(params[:panier][:duree].to_i)
  	
	  	@abonnement.save  	
  		redirect_to process_order_resume_path
  	#__________________________#
  	#						   #
  	#  SI CLIENT CONNECTER 	   #
  	#						   #
  	#__________________________#
  	else
  		@abonnement_exist = Abonnement.where('etat = "en_cours" AND client_id = ?', current_client.id)
		#____ SI ABONNEMENT EXIST __
		if @abonnement_exist.count > 0
			@abonnement_exist1 =  Abonnement.find(@abonnement_exist[0].id)
			@abonnement_exist1.etat = "annule"
			@abonnement_exist1.save
		end
		@date_debut = Date.current
	
  		@abonnement = Abonnement.new
  		@abonnement.client_id = current_client.id
  		@abonnement.panier_id = params[:panier][:id]
  		@abonnement.duree = params[:panier][:duree].to_i #EN MOIS
  		@abonnement.etat = 'en_cours'
  		@abonnement.date_debut = @date_debut
  		@abonnement.date_fin = @date_debut.months_since(params[:panier][:duree].to_i)
  	
	  	@abonnement.save
	  	
	  	redirect_to process_order_resume_path  	
  	end
  
  end
  
  
  def ajouterQuantite
  
  end
  def confirmation_abonnement
  
  end
end
