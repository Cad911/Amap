ECommerce::Application.routes.draw do
 
  resources :rel_commande_produits

  resources :commandes

  match '/' => "page_front#index", :via => :get

#______ PROCESS ORDER _________________________________________________________________________________________________
  get "process_order/resume"

  get "process_order/confirmation"

  get "process_order/paiement"
  match "process_order/select_pr" => "process_order#selectPr", :via => :get
  match "process_order/payer_commande" => "process_order#payerCommande", :via => :get

#________ ABONNEMENT ___________________________________________________________________________________________________
  resources :abonnements
  match 'abonnements/sabonner' => 'abonnements#sabonner', :via => :post, :as => :sabonner
  match 'abonnements/addQuantite/:id_abonnement' => 'abonnements#ajouterQuantite', :via => :get, :as => :add_quantite_abo
  match 'abonnements/suppQuantite/:id_abonnement' => 'abonnements#diminuerQuantite', :via => :get, :as => :supp_quantite_abo
  match 'abonnements/suppAbonnement/:id_abonnement' => 'abonnements#suppAbonnement', :via => :get, :as => :supp_abonnement
  

#______ CAGEOT _______________________________________________________________________________________________________
resources :cageots
match 'cageot/ajoutProduit' => 'cageots#ajoutProduitCageot', :via => :post, :as => :ajout_produit_cageot
match 'cageot/ajoutQuantite/:product_cageot_id' => 'cageots#ajouterQuantite', :via => :get, :as => :ajout_quantite_cageot
match 'cageot/suppQuantite/:product_cageot_id' => 'cageots#supprimerQuantite', :via => :get, :as => :supp_quantite_cageot
match 'cageot/suppProduit/:product_cageot_id' => 'cageots#supprimerProduitCageot', :via => :delete, :as => :supp_produit_cageot

#_____ CONNEXION ESPACE CLIENT __________________________________________________________________________________________________
  devise_for :clients,:controllers => {:sessions => 'sessions'} do
    delete 'client_logout' => 'devise/sessions#destroy'
  end
#_________ CLIENTS _________________________________________________________________________________________________________
  namespace :espace_client do
  		resources :clients do
  			match "edit_password" => "clients#edit_password", :via => :get
   		end
  end
  match "clients/emailExist" => "espace_client/clients#emailExist", :via => :post

#_______ PAGE REVENDEURS _________________________________________________________________________________________________________
  match "page_revendeur/index" => "page_revendeur#index", :as => :page_revendeur_index
  match "page_revendeur/index/:direction_id" => "page_revendeur#index_by_direction", :as => :page_revendeur_index_by_direction
  
  match "page_revendeur/show/:id" => "page_revendeur#show", :as => :page_revendeur_show

#____________ PAGE PRODUITS ______________________________________________________________________________________________________
  #LISTING
  match "page_produit/index" => 'page_produit#index', :as => :page_produit_index #ALL
  match "page_produit/index/user/:user_id" => 'page_produit#index_by_revendeur', :as => :page_produit_index_by_revendeur #PAR REVENDEUR / AGRICULTEUR_
  match "page_produit/index/amap/:direction_id" => 'page_produit#index_by_directeur', :as => :page_produit_index_by_directeur #PAR DIRECTION / AMAP___
  match "page_produit/index/categorie/:categorie_id" => 'page_produit#index_by_categorie', :as => :page_produit_index_by_categorie #PAR CATEGORIE______
  #SHOW
  match "page_produit/show/:user_id/:product_id" => 'page_produit#show', :as => :page_produit_show


#___________ PAGE PANIER _________________________________________________________________________________________________________
  match "page_panier/index" => 'page_panier#index', :as => :page_panier_index #ALL
  match "page_panier/index/user/:user_id" => 'page_panier#index_by_revendeur', :as => :page_panier_index_by_revendeur #PAR REVENDEUR / AGRICULTEUR_
  match "page_panier/index/amap/:direction_id" => 'page_panier#index_by_directeur', :as => :page_panier_index_by_directeur #PAR DIRECTION / AMAP___
  match "page_panier/index/categorie/:categorie_id" => 'page_panier#index_by_categorie', :as => :page_panier_index_by_categorie #PAR CATEGORIE______
  #SHOW
  match "page_panier/show/:user_id/:panier_id" => 'page_panier#show', :as => :page_panier_show 




  root :to => "devise/sessions#new"
#_____________________ CONEXION AGRICULTEUR / AMAP USER_________________________________________________________________________  		
  devise_for :users do
    delete 'user_logout' => 'devise/sessions#destroy'
  end

#_____________________ADMINISTRATION USER________________________________________________________________________________________
  namespace :administration do
    resources :users  do
      match 'revendeur' => 'users#revendeur'
      resources :produit_autorises
      resources :panier_autorises
      resources :paniers do
       	resources :produit_paniers
      end
      
      #______ ROUTE POUR IMAGE USER ____
      match 'add_image' => 'users#add_image', :via => :post
      match 'update_image/:image_id' => 'users#update_image', :as => :user_update_image, :via => :put
      match 'delete_image/:image_id' => 'users#delete_image', :as => :user_delete_image, :via => :delete
      
      resources :stocks
      match 'exist_stock/:produit_autorise_id' => "stocks#alreadyExistStock", :as => :exist_stock, :via => :get #VERIF AJAX SI PRODUIT DEJA EN STOCK
      #______ ROUTE POUR IMAGE STOCK ____
      match '/stocks/:stock_id/add_image' => 'stocks#add_image', :as => :stock_add_image, :via => :post
      match '/stocks/:stock_id/update_image/:image_id' => 'stocks#update_image', :as => :stock_update_image, :via => :put
      match '/stocks/:stock_id/delete_image/:image_id' => 'stocks#delete_image', :as => :stock_delete_image, :via => :delete
      
      
      resources :produit_vente_libres
      match 'exist_vente/:stock_id' => "produit_vente_libres#dejaEnVente", :as => :exist_vente, :via => :get #VERIF AJAX SI PRODUIT DEJA EN VENTE
    
      resources :point_relais
      match "mespointrelais" => "point_relais#indexForRevendeur", :as => :index_point_relais_for_revendeur, :via => :get
    end
  end
	
#_____________________ACTIVE ADMIN______________________________________________________________________________  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
