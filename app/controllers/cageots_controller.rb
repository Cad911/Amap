class CageotsController < InheritedResources::Base
	layout 'front'

	#__________________________________________ AFFICHE LES ARTICLES DANS LE CAGEOT ________________________________________
	def show
		if current_client.nil?
			@select_cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:cageot_id])
		else
			@select_cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
		end
		
		if @select_cageot.count > 0
			@cageot = Cageot.find(@select_cageot[0].id)
			@product_cageot =  RelCageotProduit.where("cageot_id = ? ",@cageot.id)
		
		else
			@cageot = nil
		end
	end
	
	
	#__________________________________________________________ AJOUT PRODUIT DANS LE CAGEOT _____________________________________________
	def ajoutProduitCageot
		#2 VARIABLES EN POST => params[:produit_vente_libre][:id] / params[:produit_vente_libre][:nombre_pack]
		#_________________
		#________________ SI CLIENT PAS CONNECTED _____________________
		#__________________
		flash[:notice]= ""
		if current_client.nil?
			#_____ SI ABONNEMENT CHOISI/ EXIST _______
			#_____
			@abonnement_exist = Abonnement.where("etat = 'en_cours' AND session_id = ?", session[:abonnement_id])
			if @abonnement_exist.count > 0
				@abonnement = Abonnement.find(@abonnement_exist[0].id)
				@abonnement.etat = "annule"
				@abonnement.save
				flash[:notice] = "Abonnement existant et supprimer. "
			end
			
			@cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:cageot_id])
				#________ SI CAGEOT EXISTE ________________
				if @cageot.count >0
					@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot[0].id, params[:produit_vente_libre][:id])
					#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
					if @produit_to_add.count > 0
						@produit = RelCageotProduit.find(@produit_to_add[0].id)
						@produit.nombre_pack += params[:produit_vente_libre][:nombre_pack].to_i
						if @produit.save
							flash[:notice] += "Produit update"
							@status_ajout = "update"
						    respond_to do |format|
						  		format.json { render :json => {:cageot => @cageot[0],:produit => @produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
						  		format.html { 
									redirect_to cageot_path(@cageot[0]) 
								}
						  	end
						end
					else
						if !params[:produit_vente_libre][:id].nil?
							@rel_cageot_produit = RelCageotProduit.new
							@rel_cageot_produit.cageot_id = @cageot[0].id
							@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
							@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack]
						
							if @rel_cageot_produit.save
								flash[:notice] += "Produit ajouter"
								@status_ajout = "add"
							    respond_to do |format|
							  		format.json { render :json => {:cageot => @cageot[0],:produit => @rel_cageot_produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
							  		format.html { 
										redirect_to cageot_path(@cageot[0]) 
									}
							  	end
							end
						end
					end
				#________ SI CAGEOT N'EXISTE PAS __________
				else
					session[:cageot_id] = "#{DateTime.now.to_i}"+("#{(1..100).to_a.shuffle.join}#{('a'..'z').to_a.shuffle.join}").split('').shuffle.join #__ GENERATION ID POUR PANIER __
					@new_cageot = Cageot.new({:session_id => session[:cageot_id],:etat => 'en_cours'})
					if @new_cageot.save
						#__ SI ID PRODUIT ___
						if !params[:produit_vente_libre][:id].nil?
							@rel_cageot_produit = RelCageotProduit.new
							@rel_cageot_produit.cageot_id = @new_cageot.id
							@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
							@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack]
							if @rel_cageot_produit.save
								flash[:notice] += "Produit ajoute et panier creer (info)"
								@status_ajout = "add"
								respond_to do |format|
							  		format.json { render :json => {:cageot => @cageot[0],:produit => @rel_cageot_produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
							  		format.html { 
										redirect_to cageot_path(@new_cageot) 
									}
							  	end
							end
						end
					else
						flash[:notice] = 'ERREUR'
					end
				
				end
		#_________________
		#____________________ SI CLIENT CONNECTED _________________________________________________________
		#_________________
		else
			#_____ SI ABONNEMENT CHOISI _______
			#_____
			@abonnement_exist = Abonnement.where("etat = 'en_cours' AND client_id = ?", current_client.id)
			if @abonnement_exist.count > 0
				@abonnement = Abonnement.find(@abonnement_exist[0].id)
				@abonnement.etat = "annule"
				@abonnement.save
				flash[:notice] = "Abonnement existant et supprimer. "
			end
			
			@cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
			
			#________ SI CAGEOT EXISTE ________________
			if @cageot.count >0
				@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot[0].id, params[:produit_vente_libre][:id])
				#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
				if @produit_to_add.count > 0
					@produit = RelCageotProduit.find(@produit_to_add[0].id)
					@produit.nombre_pack += params[:produit_vente_libre][:nombre_pack].to_i
					if @produit.save
						flash[:notice] = "Produit updater"
						@status_ajout = "update"
						respond_to do |format|
					  		format.json { render :json => {:cageot => @cageot[0],:produit => @produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
					  		format.html { 
								redirect_to cageot_path(@cageot[0]) 
							}
						end
					end
				else
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @cageot[0].id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
					@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack].to_i
					if @rel_cageot_produit.save
						flash[:notice] = "Produit ajouter"
						@status_ajout = "add"
						respond_to do |format|
					  		format.json { render :json => {:cageot => @cageot[0],:produit => @rel_cageot_produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
					  		format.html { 
								redirect_to cageot_path(@cageot[0]) 
							}
						end
					end
				end
			#________ SI CAGEOT N'EXISTE PAS __________
			else
				@new_cageot = Cageot.new({:client_id => current_client.id,:etat => 'en_cours'})
				if @new_cageot.save
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @new_cageot.id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
					@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack].to_i
					if @rel_cageot_produit.save
								flash[:notice] = "Produit ajoute et panier creer (info)"
								@status_ajout = "add"
								respond_to do |format|
							  		format.json { render :json => {:cageot => @cageot[0],:produit => @rel_cageot_produit,:message => flash[:notice], :statut => @status_ajout, :total => @cageot[0].total} }
							  		format.html { 
										redirect_to cageot_path(@new_cageot) 
									}
								end
							end
				else
					flash[:notice] = 'ERREUR'
				end
			end
						
		end
	end
	
	
	#__________________________________________________________ AJOUTER QUANTITE DANS LE PANIER ____________________________________________________________________
	def ajouterQuantite
		@produit_cageot = RelCageotProduit.find(params[:product_cageot_id])
		@cageot = Cageot.find(@produit_cageot.cageot_id)
		if @cageot.session_id == session[:cageot_id] || @cageot.client_id == current_client.id
			@produit_cageot.ajoutQuantite
			flash[:notice] = "Quantite agrandit"
			@produit_ajouter = true
			respond_to do |format|
			  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_ajouter, :total => @cageot.total} }
			  		format.html { 
						redirect_to cageot_path(@cageot) 
					}
				end
		end
	end
	#_____________________________________________ SUPPRIMER QUANTITE DANS LE PANIER _______________________________________
	def supprimerQuantite
		@produit_cageot = RelCageotProduit.find(params[:product_cageot_id])
		@cageot = Cageot.find(@produit_cageot.cageot_id)
		if @cageot.session_id == session[:cageot_id] || @cageot.client_id == current_client.id #__ POUR EVITER QU'UN UTILISATEUR N'AYANT PAS LE DROIT METTENT A JOUR
			#__ SI IL NE RESTE QU'UN PACK ALORS ON SUPPRIME LE PRODUIT DU PANIER
			if @produit_cageot.nombre_pack == 1
				@produit_cageot.destroy
				flash[:notice] = "Produit supprimer car il n en rester qu un"
				@produit_supprimer = "delete"
				respond_to do |format|
			  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_supprimer, :total => @cageot.total} }
			  		format.html { 
						redirect_to cageot_path(@cageot) 
					}
				end
			else
				@produit_cageot.suppQuantite
				flash[:notice] = "Quantite diminue"
				@produit_supprimer = "update"
				respond_to do |format|
			  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_supprimer, :total => @cageot.total} }
			  		format.html { 
						redirect_to cageot_path(@cageot) 
					}
				end
			end
		end
	end
	
	
	#___________________________________________________ SUPPRIMER LE PRODUIT DU PANIER _______________________________________
	def supprimerProduitCageot
		@produit_cageot = RelCageotProduit.find(params[:product_cageot_id])
		@cageot = Cageot.find(@produit_cageot.cageot_id)
		if @cageot.session_id == session[:cageot_id] || @cageot.client_id == current_client.id
			if @produit_cageot.destroy
				flash[:notice] = "Produit supprimer"
				@produit_supprimer = true
				respond_to do |format|
			  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_supprimer, :total => @cageot.total} }
			  		format.html { 
						redirect_to cageot_path(@new_cageot) 
					}
				end
			else
				flash[:notice] = "Une erreur est survenue"
				@produit_supprimer = false
				respond_to do |format|
			  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_supprimer, :total => @cageot.total} }
			  		format.html { 
						redirect_to cageot_path(@new_cageot) 
					}
				end
			end
			
		else
		    flash[:notice] = "Ce produit ne vous appartient pas"
		    @produit_supprimer = false
			respond_to do |format|
		  		format.json { render :json => {:cageot => @cageot,:produit => @produit_cageot,:message => flash[:notice],:statut => @produit_supprimer, :total => @cageot.total} }
		  		format.html { 
					redirect_to cageot_path(@new_cageot) 
				}
			end
		end
		
	end
	
	
	
	
	
end
