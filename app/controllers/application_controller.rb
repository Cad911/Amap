class ApplicationController < ActionController::Base
  protect_from_forgery
  
   #POUR CANCAN ________________________________________
  def current_ability
  	@current_ability ||= case
  						 when current_user
  						 	 UserAbility.new(current_user)
  						 when current_client
  						 	 ClientAbility.new(current_client)
  						 else 
  						 	GuestAbility.new
  						 end			  		
  end
   #EXCEPTION CANCAN __________________________________
  #rescue_from CanCan::AccessDenied do |exception|
    #redirect_to administration_user_path(current_user.id), :alert => exception.message
  #end
  
  #____ REDIRECTION APRES LE LOGIN-LOGOUT _______
  def after_sign_in_path_for(resource)
  		if resource.is_a?(User)
    		administration_user_path(current_user.id)
    	elsif resource.is_a?(Client)
    		espace_client_client_path(current_client.id)
    	else
    		admin_dashboard_path
    	end
  end
  
   def after_sign_out_path_for(resource_or)
     if resource_or.is_a?(User) || resource_or == :user
    	new_user_session_path
     elsif resource_or.is_a?(Client) || resource_or == :client
     	new_client_session_path
     else
       new_admin_user_session_path()
     end
  end
  
  
  
  #____ RECUPERATION ERREUR ________________________________________
  rescue_from ActiveRecord::RecordNotFound, :with => :render_missing
  
  def render_missing
  	render :file => "public/404.html", :status => 404
  end
end
