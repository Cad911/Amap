class CageotsController < InheritedResources::Base


	#__ AFFICHE LES ARTICLES DANS LE CAGEOT _____
	def showCageot
		if current_client.nil?
			@cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:panier_id])
		else
			@cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
		end
	end
	
	
	#______________________________________ AJOUT PRODUIT DANS LE CAGEOT _________________________
	def ajoutProduitCageot
		#________________ SI CLIENT PAS CONNECTED _____________________
		if current_client.nil?
			@cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:panier_id])
				#________ SI CAGEOT EXISTE ________________
				if @cageot.count >0
					@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot.id, params[:produit_vente_libre_id])
					#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
					if @produit_to_add.count > 0
						@produit_to_add.nombre_pack += params[:nombre_pack]
					else
						@rel_cageot_produit = RelCageotProduit.new
						@rel_cageot_produit.cageot_id = @cageot.id
						@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
						@rel_cageot_produit.nombre_pack = params[:nombre_pack]
					end
				#________ SI CAGEOT N'EXISTE PAS __________
				else
					session[:panier_id] = ("#{DateTime.now.to_i}#{('a'..'z').to_a.shuffle.join}").split('').shuffle.join #__ GENERATION ID POUR PANIER __
					@new_cageot = Cageot.new({:session_id => session[:panier_id],:etat => 'en_cours'})
					if @new_cageot.save
						@rel_cageot_produit = RelCageotProduit.new
						@rel_cageot_produit.cageot_id = @new_cageot.id
						@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
						@rel_cageot_produit.nombre_pack = params[:nombre_pack]
					else
						flash[:notice] = 'ERREUR'
					end
				
				end
		
		#_______________ SI CLIENT CONNECTED ________________________
		else
			@cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
			
			#________ SI CAGEOT EXISTE ________________
			if @cageot.count >0
				@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot.id, params[:produit_vente_libre_id])
				#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
				if @produit_to_add.count > 0
					@produit_to_add.nombre_pack += params[:nombre_pack]
				else
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @cageot.id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
					@rel_cageot_produit.nombre_pack = params[:nombre_pack]
				end
			#________ SI CAGEOT N'EXISTE PAS __________
			else
				@new_cageot = Cageot.new({:client_id => current_client.id,:etat => 'en_cours'})
				if @new_cageot.save
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @new_cageot.id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
					@rel_cageot_produit.nombre_pack = params[:nombre_pack]
				else
					flash[:notice] = 'ERREUR'
				end
			end
						
		end
	end
	
	
	
	
	
end
