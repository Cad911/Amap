class Administration::UsersController < InheritedResources::Base
load_and_authorize_resource #LOAD IMPERATIF LORSQU'IL Y A UNE CONDITION DANS LE ABILITY, ICI AVEC l'ID

	# _____________________________________ AFFICHAGE REVENDEUR ____________________________________________________
	def revendeur
		@revendeurs = User.where(:direction_id => params[:user_id])
		authorize! :manage, User.find(params[:user_id]) #AUTORISATION POUR LA PAGE REVENDEUR
	end
	
	
	
	
	
	
	# _____________________________________ SHOW ____________________________________________________
	def show
		@user = User.find(params[:id])
		@title_user = ""
		if current_user.id == params[:id].to_i
			@title_user = "Mes informations"
		else
			@title_user = "Informations agriculteurs"
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
	  		flash[:notice] = 'User mis a jour'
	  		redirect_to administration_user_path(@user)
	  	else
	  		render 'edit'
	  	end
	end

end
