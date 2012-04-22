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
  		@abonnement.quantite = 1
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
  
  #_________________________________________________ AJOUT QUANTITE ___________________________________________________
  def ajouterQuantite
  	#_____ PARAMS ENVOYER ID Abonnement ____
  	@abonnement = Abonnement.find(params[:id_abonnement])
  	@isnt_yours = 0
  	if Abonnement.exists?(@abonnement)
  		
  		#______ VERIF SI CLIENT CONNECTED OR NOT AND SI ABONNEMENT ASSOCIE AU CLIENT OU A LA SESSION ______
  		if current_client.nil?
	  		if @abonnement.session_id != session[:abonnement_id]
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	else
	  		if @abonnement.client_id != current_client.id
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	end
  		
  		if @isnt_yours == 0
	  		@abonnement.quantite += 1
	  		if @abonnement.save
	  			flash[:notice] = "Quantite panier/abonnmement updater"
	  			redirect_to process_order_resume_path
	  		else
	  			flash[:notice] = "ERREUR"
	  			redirect_to process_order_resume_path
	  		end
	  	else
	  		redirect_to process_order_resume_path
	  	end
  	else
  		flash[:notice] = "Abonnement n'existe pas"
  		redirect_to process_order_resume_path
  	end
  end
  

  #_________________________________________________ AJOUT QUANTITE ___________________________________________________
  def diminuerQuantite
  	#_____ PARAMS ENVOYER ID Abonnement ____
  	@abonnement = Abonnement.find(params[:id_abonnement])
  	@isnt_yours = 0
  	if Abonnement.exists?(@abonnement)
  		
  		#______ VERIF SI CLIENT CONNECTED OR NOT AND SI ABONNEMENT ASSOCIE AU CLIENT OU A LA SESSION ______
  		if current_client.nil?
	  		if @abonnement.session_id != session[:abonnement_id]
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	else
	  		if @abonnement.client_id != current_client.id
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	end
  		
  		if @isnt_yours == 0
  			if @abonnement.quantite == 1
  				#___ ON ANNULE LABONNEMENT
  				@abonnement.etat = 'annule'
  				if @abonnement.save
  					flash[:notice] = "Abonnement enlever du panier"
  					redirect_to process_order_resume_path
  				end
  			else
  				@abonnement.quantite -= 1
		  		if @abonnement.save
		  			flash[:notice] = "Quantite panier/abonnmement diminuer"
		  			redirect_to process_order_resume_path
		  		else
		  			flash[:notice] = "ERREUR"
		  			redirect_to process_order_resume_path
		  		end
  			end
	  	else
	  		redirect_to process_order_resume_path
	  	end
  	else
  		flash[:notice] = "Abonnement n'existe pas"
  		redirect_to process_order_resume_path
  	end
  end
  
  #___________________________________ SUPP ABONNEMENT DU PANIER _________________________________________________________
  def suppAbonnement
  	#_____ PARAMS ENVOYER ID Abonnement ____
  	@abonnement = Abonnement.find(params[:id_abonnement])
  	@isnt_yours = 0
  	if Abonnement.exists?(@abonnement)
  		
  		#______ VERIF SI CLIENT CONNECTED OR NOT AND SI ABONNEMENT ASSOCIE AU CLIENT OU A LA SESSION ______
  		if current_client.nil?
	  		if @abonnement.session_id != session[:abonnement_id]
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	else
	  		if @abonnement.client_id != current_client.id
	  			flash[:notice] = "Cet abonnement n'est pas a vous"
	  			@isnt_yours = 1
	  		end
	  	end
  		
  		if @isnt_yours == 0
  			#__ ON ANNULE LABONNEMENT
	  		@abonnement.etat = 'annule'
	  		if @abonnement.save
	  			flash[:notice] = "Abonnement supprimer"
	  			redirect_to process_order_resume_path
	  		else
	  			flash[:notice] = "ERREUR"
	  			redirect_to process_order_resume_path
	  		end
	  	else
	  		redirect_to process_order_resume_path
	  	end
  	else
  		flash[:notice] = "Abonnement n'existe pas"
  		redirect_to process_order_resume_path
  	end
  end
  
  
 
  #_____________________________________ CONFIRMATION ABONNEMENT __________________________________________________________ 
  def confirmation_abonnement
  
  end
end
