class CageotsController < InheritedResources::Base
	layout 'front'

	#__ AFFICHE LES ARTICLES DANS LE CAGEOT _____
	def show
		if current_client.nil?
			@select_cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:panier_id])
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
	
	
	#______________________________________ AJOUT PRODUIT DANS LE CAGEOT _________________________
	def ajoutProduitCageot
		#2 VARIABLES EN POST => params[:produit_vente_libre][:id] / params[:produit_vente_libre][:nombre_pack]
		#_________________
		#________________ SI CLIENT PAS CONNECTED _____________________
		#__________________
		if current_client.nil?
			@cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:panier_id])
				#________ SI CAGEOT EXISTE ________________
				if @cageot.count >0
					@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot[0].id, params[:produit_vente_libre][:id])
					#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
					if @produit_to_add.count > 0
						@produit = RelCageotProduit.find(@produit_to_add[0].id)
						@produit.nombre_pack += params[:produit_vente_libre][:nombre_pack].to_i
						if @produit.save
							flash[:notice] = "Produit updater"
							redirect_to cageot_path(@cageot[0])
						end
					else
						if !params[:produit_vente_libre][:id].nil?
							@rel_cageot_produit = RelCageotProduit.new
							@rel_cageot_produit.cageot_id = @cageot[0].id
							@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
							@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack]
						
							if @rel_cageot_produit.save
								flash[:notice] = "Produit ajouter"
								redirect_to cageot_path(@cageot)
							end
						end
					end
				#________ SI CAGEOT N'EXISTE PAS __________
				else
					session[:panier_id] = ("#{DateTime.now.to_i}#{('a'..'z').to_a.shuffle.join}").split('').shuffle.join #__ GENERATION ID POUR PANIER __
					@new_cageot = Cageot.new({:session_id => session[:panier_id],:etat => 'en_cours'})
					if @new_cageot.save
						#__ SI ID PRODUIT ___
						if !params[:produit_vente_libre][:id].nil?
							@rel_cageot_produit = RelCageotProduit.new
							@rel_cageot_produit.cageot_id = @new_cageot.id
							@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre][:id]
							@rel_cageot_produit.nombre_pack = params[:produit_vente_libre][:nombre_pack]
							if @rel_cageot_produit.save
								flash[:notice] = "Produit ajoute et panier creer (info)"
								redirect_to cageot_path(@new_cageot)
							end
						end
					else
						flash[:notice] = 'ERREUR'
					end
				
				end
		#_________________
		#_______________ SI CLIENT CONNECTED _________________________________________________________
		#_________________
		else
			@cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
			
			#________ SI CAGEOT EXISTE ________________
			if @cageot.count >0
				@produit_to_add = RelCageotProduit.where("cageot_id = ? AND produit_vente_libre_id = ?",@cageot[0].id, params[:produit_vente_libre_id])
				#________ SI PRODUIT EXISTE DEJA DANS LE CAGEOT _________
				if @produit_to_add.count > 0
					@produit = RelCageotProduit.find(@produit_to_add[0].id)
					@produit.nombre_pack += params[:nombre_pack]
					if @produit.save
						flash[:notice] = "Produit updater"
						redirect_to cageot_path(@cageot[0])
					end
				else
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @cageot[0].id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
					@rel_cageot_produit.nombre_pack = params[:nombre_pack]
					if @rel_cageot_produit.save
						flash[:notice] = "Produit ajouter"
						redirect_to cageot_path(@cageot)
					end
				end
			#________ SI CAGEOT N'EXISTE PAS __________
			else
				@new_cageot = Cageot.new({:client_id => current_client.id,:etat => 'en_cours'})
				if @new_cageot.save
					@rel_cageot_produit = RelCageotProduit.new
					@rel_cageot_produit.cageot_id = @new_cageot.id
					@rel_cageot_produit.produit_vente_libre_id = params[:produit_vente_libre_id]
					@rel_cageot_produit.nombre_pack = params[:nombre_pack]
					if @rel_cageot_produit.save
								flash[:notice] = "Produit ajoute et panier creer (info)"
								redirect_to cageot_path(@new_cageot)
							end
				else
					flash[:notice] = 'ERREUR'
				end
			end
						
		end
	end
	
	
	
	
	
end
