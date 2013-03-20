class Administration::UsersController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID
protect_from_forgery :except => [:add_image, :delete_image] 
	# _____________________________________ AFFICHAGE REVENDEUR ____________________________________________________
	def revendeur
		@revendeurs = User.where(:direction_id => params[:user_id])
		authorize! :manage, User.find(params[:user_id]) #AUTORISATION POUR LA PAGE REVENDEUR
	end


	# _____________________________________ SHOW ____________________________________________________
	def show
		@user = User.find(params[:id])
		@title_user = ""
		@photo_user = PhotoUser.new
		if current_user.id == params[:id].to_i
			@title_user = "Mes informations"
		else
			@title_user = "Informations agriculteurs"
		end
		
		respond_to do |format|
  			format.json { render :json => {
  					:status => 'OK',
  					:user => @user
  				} 
  			}
  			format.html { render :show }
  		end
	end
	
	
	
	# _____________________________________ CREATE ____________________________________________________
	def create
		@user = User.new(params[:user])
		@user.direction_id = current_user.id
			if @user.save
		  		flash[:notice] = 'Revendeur ajoute'
			  	 		redirect_to [:administration,@user]
		  	else
		  		render 'new'
		  	end
	end
	
	def edit
	
	end
	
		
	# _____________________________________ UPDATE ____________________________________________________
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
	  		respond_to do |format|
  			format.json { render :json => {
  					:status => 'OK',
  					:user => @user
  				} 
  			}
  			format.html { 
  				flash[:notice] = 'User mis a jour'
  				render :show
  			}
  		end
  		
	  		
	  	else
	  		render 'edit'
	  	end
	end
	
	
  
  #____________________________________________________________________________________
  #____________________________________________________________________________________
  #__________________________________ IMAGE ___________________________________________
  #____________________________________________________________________________________
  #____________________________________________________________________________________
  
	
  #_________________________________ ADD IMAGE _______________________________________
  def add_image
	    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
		params[:photo_user][:first_image] = params[:photo_user][:first_image].to_i
		if params[:photo_user][:first_image] == 1
			@photo_first_image = PhotoUser.where('user_id = ? AND first_image = 1', current_user.id)
			if @photo_first_image.count > 0
				@photo_first_image[0].first_image = 0
				@photo_first_image[0].save	
			end
		else
			@photo_first_image = PhotoUser.where('user_id = ? AND first_image = 1', current_user.id)
			#__ SI PAS ENCORE DIMAGE PAR DEFAUT, ON L'APPLIQUE __
			if @photo_first_image.count == 0
				params[:photo_user][:first_image] = 1
			end	
		end
		@photo_user = PhotoUser.new
		@photo_user.user_id = current_user.id
		@photo_user.update_attributes(params[:photo_user])
		#redirect_to [:administration,current_user]
		
		render :json => {:photo_user => @photo_user}
  end



  #_________________________________ UPDATE  IMAGE _______________________________________
  def update_image
  	params[:photo_user][:first_image] = params[:photo_user][:first_image].to_i
    @image = PhotoUser.find(params[:image_id])
    #____  SI IMAGE MISE EN PLACE IMAGE PAR DEFAUT
	if params[:photo_user][:first_image] == 1
		#___ SI PAS DE CHANGEMENT ______
		if @image.first_image == 1
			flash[:notice] = "Aucun changement"
		else
			@photo_first_image = PhotoUser.where('user_id = ? AND first_image = 1', current_user.id)
			if @photo_first_image.count > 0
				@photo_first_image[0].first_image = 0
				@photo_first_image[0].save	
			end
			@image.first_image = params[:photo_user][:first_image]
			@image.save
			flash[:notice] = "Modification photo user effectuer"
		end
	else
		#___ SI ON ENLEVE L IMAGE PAR DEFAUT ______
		if @image.first_image == 1
			flash[:notice] = "Il est obligatoire d avoir une image par defaut"
		else
			flash[:notice] = "Aucun changement"
		end
	end
	redirect_to [:administration,current_user]
  end

  #____________________________ DELETE IMAGE _________________________________________________
  def delete_image
  	@image_user = PhotoUser.find(params[:image_id])
  	@image_user.remove_image = true
  	@image_user.destroy
  	
  	render :nothing => true
  end

end
