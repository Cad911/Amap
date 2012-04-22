class Administration::PointRelaisController < InheritedResources::Base
	
	load_and_authorize_resource
	
	def index
		@point_relais = PointRelai.where(:user_id => current_user.id)
	end
	def indexForRevendeur
		@point_relais = PointRelai.where(:user_id => current_user.direction.id)
		render "index"
	end
	#def show
	#end
	
	#def edit
	#end 
	
	def update
		@point_relai = PointRelai.find(params[:id])
		@point_relai.user_id = current_user.id
		@point_relai.ville_id = params[:point_relai][:ville_id]
		@point_relai.adresse = params[:point_relai][:adresse]
		if @point_relai.save
			flash[:notice] = "Point relai modifie"
			redirect_to administration_user_point_relai_path(current_user.id, @point_relai)
		else
			flash[:notice] = "ERREUR POINT RELAI"
			render "edit"
		end
			
	end
	
	#def new
	#end
	
	def create
		@point_relai = PointRelai.new
		@point_relai.user_id = current_user.id
		@point_relai.ville_id = params[:point_relai][:ville_id]
		@point_relai.adresse = params[:point_relai][:adresse]
		if @point_relai.save
			flash[:notice] = "Point relais cree"
			redirect_to administration_user_point_relai_path(current_user.id, @point_relai)
		else
			flash[:notice] = "ERREUR POINT RELAI"
			render "new"
		end
	end
end
