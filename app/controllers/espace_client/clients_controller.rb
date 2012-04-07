class EspaceClient::ClientsController < InheritedResources::Base
	load_and_authorize_resource
	layout 'espace_client'
	
	#______ EDIT PASSWORD ________________
	def edit_password
		@client = Client.find(current_client.id)
	end
	
	#______ UPDATE ________________
	def update
		@client = Client.find(current_client.id)
		
		#___ SI UPDATE INFOS ___
		if params[:client][:password_confirmation].nil?
			if @client.update_attributes(params[:client])
			      		flash[:notice] = "Infos modifie"
			      		redirect_to espace_client_client_path(@client) 
			   		 else
			      		render "edit"
			    	end
		#___ SI UPDATE MDP ___
		else 
			if @client.valid_password?(params[:client][:actual_password])
				if params[:client][:password] == params[:client][:password_confirmation]
					@client.password = params[:client][:password]
			    	if @client.save
			      		# Sign in the user by passing validation in case his password changed
			      		sign_in @client, :bypass => true
			      		flash[:notice] = "Mot de passe modifie"
			      		redirect_to espace_client_client_path(@client)
			   		 else
			      		render "edit_password"
			    	end
			    else
			    	flash[:notice] = "Les 2 mot de passe ne correspondent pas"
		    		render "edit_password"
			    end
		    else
		    	flash[:notice] = "Mauvais mot de passe"
		    	render "edit_password"
		    end
	    end
	end
	
end
