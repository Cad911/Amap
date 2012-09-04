class UserAbility
  include CanCan::Ability

  def initialize(user)
  
  	user ||= new.User
  	
  	if user.nil?
	  	
	else
		# ______________________________________ SI DIRECTEUR / AMAP ___________________________________
	  	if user.has_revendeur
	  		cannot :index, User
	  		can :create, User
	  		can :manage , User, :id => user.id
	  		can [:show,:update,:destroy,:add_image], User, :direction_id => user.id #PEUT MANAGER SEULEMENT SES REVENDEUR
	  		
	  		can :index, PointRelai
	  		can :manage, PointRelai, :user_id => user.id
	  		can :create, PointRelai
	  	end
	  	
	  	# ______________________________________ METTRE DES PRODUITS AUTORISES ___________________________________
	  	if user.autorisation_produit
	  		can :index, User
	  		can [:show,:update], User, :id => user.id
	  		
	  		can :manage, ProduitAutorise, :user_id => user.id
	  		can :create, ProduitAutorise
	  		
	  		can :manage, PanierAutorise, :user_id => user.id
	  		can :create, PanierAutorise
	  	end
	  	
	  	# ______________________________________ VENDRE AVEC RESTRICTION ___________________________________
	  	if user.can_stock_ar
	  		can :index, User
	  		can [:show,:update,:add_image], User, :id => user.id
	  		
	  		can :manage, Stock, :user_id => user.id
	  		can :create, Stock
	  		
	  		can :manage, ProduitVenteLibre, :user_id => user.id
	  		can :create, ProduitVenteLibre
	  		
	  		can :show, ProduitAutorise, :user_id => user.direction.id #POUR LE JS, PRE REMPLISSAGE DES INPUT
	  		
	  		can :manage, Panier, :revendeur_id => user.id
	  		can [:create, :create_declinaison], Panier
	  		#can :create_declinaison, Panier
	  		
	  		can :manage, ProduitPanier, :panier => {:revendeur_id => user.id}
	  		can :create, ProduitPanier
	  		
	  		can :indexForRevendeur,PointRelai
	  		can :show, PointRelai, :user_id => user.direction_id
	  		
	  		can [:add_image,:update_image], User, :user_id => user.id 
	  	end
	  	
	  	# ______________________________________ VENDRE AVEC RESTRICTION ___________________________________
	  	if user.can_stock_sr
	  		can :index, User
	  		can [:show,:update,:add_image], User, :id => user.id
	  		
	  		can :manage, Stock, :user_id => user.id
	  		can :create, Stock
	  		
	  		can :manage, ProduitVenteLibre, :user_id => user.id
	  		can :create, ProduitVenteLibre
	  		
	  		can :manage, Panier, :revendeur_id => user.id
	  		can [:create, :create_declinaison], Panier
	  		
	  		can :manage, ProduitPanier, :panier => {:revendeur_id => user.id}
	  		can :create, ProduitPanier
	  		
	  		can [:add_image,:update_image], User, :user_id => user.id 
	  	end
	end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
