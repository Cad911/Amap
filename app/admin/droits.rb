ActiveAdmin.register Droit do
  
  #___________________________________FORMULAIRE EDIT / NEW ____________________________________
   form do |f|
  		f.inputs "Informations" do
  			f.input :nom, :label => "Nom du droit"
        	f.input :has_revendeur,:label => "Creer des revendeurs",:as => :select, :collection => {'Oui' =>'1','Non'=>'0'}
        	f.input :autorisation_produit,:label => "Mettre des produits/paniers autorises",:as => :select, :collection => {'Oui' =>'1','Non'=>'0'}
        	f.input :can_stock_ar,:label => "Peut avoir un stock et revendre avec restriction",:as => :select, :collection => {'Oui' =>'1','Non'=>'0'}
        	f.input :can_stock_sr,:label => "Peut avoir un stock et revendre sans restriction",:as => :select, :collection => {'Oui' =>'1','Non'=>'0'}
		end
		
		#f.semantic_fields_for :droit do |d|
		#	d.inputs :has_revendeur, :name => "Code postal"
		#end
      	f.buttons
    end




end
