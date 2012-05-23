class EspaceClient::ClientsController < InheritedResources::Base
	#load_and_authorize_resource
    skip_load_and_authorize_resource :only => :emailExist
	layout 'espace_client'
	
	#___________________________ CREATE _____________________________________
	def create 
		@client = Client.new(params[:client])
		if @client.save
		    sign_in(:client,@client) #Connexion devise
		    #_____________ PARTIE OÙ ON RATTACHE LE CAGEOT OU L'ABONNEMENT A L'UTILISATEUR ____________
		    @abonnement_en_cours = Abonnement.where("etat = 'en_cours' AND session_id = ?", session[:abonnement_id])
		    @cageot__en_cours = Cageot.where('etat = "en_cours" AND session_id = ?',session[:cageot_id])
		    if @abonnement_en_cours.count > 0
		    	@abonnement_user = Abonnement.find(@abonnement_en_cours[0].id)
		    	@abonnement_user.client_id = @client.id
		    	@abonnement_user.save
		    elsif @cageot__en_cours.count > 0
		    	@cageot_user = Cageot.find(@cageot__en_cours[0].id)
		    	@cageot_user.client_id = @client.id
		    	@cageot_user.save
		    end
		    #__________________________________________________________________________________________
			respond_to do |format|
  				format.json { render :json => [@client] }
  				format.js { render :json => [@client] }
  				format.html { redirect_to espace_client_client_path(@client) }
  			end
		else
			respond_to do |format|
  				format.json { render :json => {error:@client.errors} }
  				#format.js { render :json => "erreur" }
  				#format.html {  }
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
	  @good_format = true
	  #@expression = "/^[\w.-]+ @ [\w]{2,} \. [a-z]{2,4}$/" # les '/' definissent le debut et la fin du regex 
	  if params[:email].match(/^[\w.-]+@[\w]{2,}\.[a-z]{2,4}$/).nil?
	  	@good_format = false
	  end
	  
	  if @email_exist.count > 0
	  	@exist = true
	  else
	    @exist = false
	  end
	  respond_to do |format|
  		format.json { render :json => {:exist => @exist, :good_format => @good_format}}
  		#format.html { render :show }
  	  end 
	end
	
	
	
end
