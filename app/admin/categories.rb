ActiveAdmin.register Categorie do
  #___________________________________FORMULAIRE EDIT / NEW ____________________________________
   form do |f|
  		f.inputs "Informations" do
        	f.input :nom
        	f.input :abbreviation
		end      
      	f.buttons
    end
    
    
    #___________________________________SHOW ____________________________________
    show do |d|
      attributes_table do      	
        row :nom
        row :abbreviation
      end
    end
end
