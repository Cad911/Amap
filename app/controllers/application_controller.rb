class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  before_filter :breadcrumb
  #add_breadcrumb('home', :root_path)
  
  def breadcrumb
  	@tab_breadcrumb = []
  	@tab_breadcrumb.push({:path => root_path, :title => 'Accueil'})
  end
  
    
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
    		if current_user.autorisation_produit
    			administration_user_produit_autorises_path(current_user.id)
    		else
    			administration_user_path(current_user.id)
    		end
    	elsif resource.is_a?(Client)
    		#__ ASSOCIATION CAGEOT A L'UTILISATEUR SI IL EXISTE __
    		if !session[:cageot_id].nil?
    			@cageot_session = Cageot.where('etat = "en_cours" AND session_id = ?', session[:cageot_id])
    			@cageot_user = Cageot.where("client_id = ? AND etat='en_cours'", current_client.id)
    			if @cageot_user.count > 0 # __ SI LE CLIENT AVAIT UN PANIER AUPARAVANT ___
    				@cageot_annule = Cageot.find(@cageot_user[0].id)
    				@cageot_annule.etat = "annule"
    				@cageot_annule.save
    			end
    			if @cageot_session.count > 0 #__ SI PANIER EN COURS  __
    				@cageot = Cageot.find(@cageot_session[0].id)
    				@cageot.client_id = current_client.id
    				@cageot.save
    			end
    		end
    		#__ ASSOCIATION PANIER/ABONNEMENT A L'UTILISATEUR SI IL EXISTE __
    		if !session[:abonnement_id].nil?
    			@abonnement_session = Abonnement.where('etat = "en_cours" AND session_id = ?', session[:abonnement_id])
    			@abonnement_user = Abonnement.where("client_id = ? AND etat='en_cours'", current_client.id)
    			if @abonnement_user.count > 0
    				@abonnement_annule = Abonnement.find(@abonnement_user[0].id)
    				@abonnement_annule.etat = "annule"
    				@abonnement.save
    			end
    			if @abonnement_session.count > 0 && @abonnement_user.count == 0 #__ SI PANIER EN COURS ET CLIENT N A PAS DE PANIER __
    				@abonnement = Abonnement.find(@abonnement_session[0].id)
    				@abonnement.client_id = current_client.id
    				@abonnement.save
    			end
    		end
    		flash[:notice] = "Bienvenue dans votre compte"
    		espace_client_client_path(current_client.id)
    	else
    		admin_dashboard_path
    	end
  end
  
   def after_sign_out_path_for(resource_or)
     if resource_or.is_a?(User) || resource_or == :user
    	new_user_session_path
     elsif resource_or.is_a?(Client) || resource_or == :client
     	#__UPDATE CAGEOT ____
     	@cageot = Cageot.where(:session_id => session[:panier_id])
     	if @cageot.count > 0
	     	@cageot_modif = Cageot.find(@cageot[0].id)
	     	@cageot_modif.etat = 'annule'
	     	@cageot_modif.save
     	end
     	
     	#___UPDATE COMMANDE EN COURS EN COMMANDE ANNULE
     	@commande_encours = Commande.where('etat = "en_cours" AND client_id', current_client.id)
     	if @commande_encours.count > 0
     	    @commande_encours[0].etat = 'annule'
     	    @commande_encours[0].save()
     	    
     	end
     	index_front_path
     else
       new_admin_user_session_path()
     end
  end
  
  
  
  #____ RECUPERATION ERREUR ________________________________________
  rescue_from ActiveRecord::RecordNotFound, :with => :render_missing
  
  rescue_from CanCan::AccessDenied, :with => :render_acces
  def render_missing
  	render :file => "public/404.html", :status => 404
  end
  
  def render_acces
  	render :file => "public/422.html", :status => 422
  end
end
