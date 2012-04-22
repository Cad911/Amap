ActiveAdmin.register Entite do
    
    #___________________________________FORMULAIRE EDIT / NEW ____________________________________
   form do |f|
  		f.inputs "Informations" do
        	f.input :nom
        	f.input :droit,:as => :select, :collection => Droit.all.map{ |d| [d.nom,d.id]}
		end
		
		#f.semantic_fields_for :droit do |d|
		#	d.inputs :has_revendeur, :name => "Code postal"
		#end
      	f.buttons
    end
    
    
    #___________________________________SHOW ____________________________________
    show do |d|
      attributes_table do
      	row :nom
        row :droit do
        	d.droit.nom
        end
      end
    end

end
