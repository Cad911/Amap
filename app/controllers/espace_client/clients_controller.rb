class EspaceClient::ClientsController < InheritedResources::Base
	load_and_authorize_resource
    skip_load_and_authorize_resource :only => :emailExist
	layout 'espace_client'
	
	#___________________________ CREATE _____________________________________
	def create 
		@client = Client.new(params[:client])
		if @client.save
			respond_to do |format|
  				format.json { render :json => [@client] }
  				#format.html { render :show }
  			end
		end
	end
	#___________________________ EDIT PASSWORD ____________________________
	def edit_password
		@client = Client.find(current_client.id)
	end
	
	#______________________________ UPDATE __________________________________
	def update
		@client = Client.find(current_client.id)
		
		#_________ SI UPDATE INFOS _________
		if params[:client][:password_confirmation].nil?
			if @client.update_attributes(params[:client])
			      		flash[:notice] = "Infos modifie"
			      		redirect_to espace_client_client_path(@client) 
			   		 else
			      		render "edit"
			    	end
		#_________ SI UPDATE MDP _________
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
	
	
	#__________________ VERIF EMAIL EXIST ________________________
	def emailExist
	  @email_exist = Client.where(:email => params[:email])
	  @exist = false
	  if @email_exist.count > 0
	  	@exist = true
	  else
	    @exist = false
	  end
	  respond_to do |format|
  		format.json { render :json => @exist }
  		#format.html { render :show }
  	  end 
	end
	
	
	
end
