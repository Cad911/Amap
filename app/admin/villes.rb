ActiveAdmin.register Ville do
   
   
   
   #___________________________________FORMULAIRE EDIT / NEW ____________________________________
   form do |f|
  		f.inputs "Informations" do
  			f.input :region, :as => :select, :collection => Region.all.map{ |r| [r.nom, r.id]}
        	f.input :nom
        	f.input :cp, :label => "Code postal"
		end      
      	f.buttons
    end
    
    
    #___________________________________SHOW ____________________________________
    show do |d|
      attributes_table do
      	row :region do
      		d.region.nom
      	end
      	
        row :nom
        row :cp
      end
    end
    
    
end
