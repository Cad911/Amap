ActiveAdmin.register Region do
  
  
   #___________________________________FORMULAIRE EDIT / NEW ____________________________________
   form do |f|
  		f.inputs "Informations" do
        	f.input :nom
        	f.input :cp, :label => "Code postal"
		end      
      	f.buttons
    end
    
    
    #___________________________________SHOW ____________________________________
    show do |d|
      attributes_table do
        row :nom
        row :cp
      end
    end
    
end
