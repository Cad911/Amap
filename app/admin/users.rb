ActiveAdmin.register User do
  
  		#__________________________________NEW / EDIT __________________________________
		  form do |f|
		  	f.inputs "Login" do
		  		f.input :email
		  		f.input :password
		  	end
		  	
		  	f.inputs "Informations" do
		  		f.input :ville, :as => :select, :collection => Ville.all.map{ |v| [v.nom, v.id]}
		  		f.input :entite, :as => :select, :collection => Entite.all.map{ |e| [e.nom, e.id]}
		  		f.input :direction_id, :as => :select, :collection => User.where('entite_id = "1"').map{ |e| [e.nom, e.id]}
		  		f.input :nom
		  		f.input :prenom
		  		f.input :nom_societe
		  	end
		  	f.buttons
		  end
	  
  
	    #___________________________________SHOW ____________________________________
	    show do |d|
	      attributes_table do
	      	row :entite do
	      		d.entite.nom
	      	end
	      	row :email
	      	row :ville do
	      		d.ville.nom
	      	end
	      	
	        row :nom
	        row :prenom
	        row :nom_societe
	      end
	    end
  
  
  
	  #_______________________________________INDEX________________________________________
	  index do
	  	column :email do |user|
	    	link_to user.email, admin_user_path(user)if !user.email.nil?
	  	end
	 	column :entite do |user|
	 		link_to user.entite.nom, admin_entite_path(user.entite_id)if !user.entite.nil?
	 	end
	  	column :ville do |user|
	  		link_to user.ville.nom, admin_ville_path(user.ville) if !user.ville.nil?
	  	end
	  	
	  	column :nom
	  	column :prenom
	  	column :nom_societe
	  	
	  	default_actions
	  end
	 
		# Filter only by title
		filter :title
  
end
