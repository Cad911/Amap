class Administration::AbonnementsController < ApplicationController
  
  #_____ LISTING DES ABONNEMENTS ____
  def index
      @mes_paniers = Panier.where(:revendeur_id => current_user.id)
      @mes_abonnements_paye = []
      
      
      if @mes_paniers.count > 0
	      @mes_paniers.each do |panier|
	           @some_abonnement = Abonnement.where('panier_id = ? AND etat = "paye"',panier.id)
	           
	           if @some_abonnement.count > 0
	               @some_abonnement.each do |abonnement|
	                   @mes_abonnements_paye.push(abonnement)
	               end 
	           end
	      end
	  end
	  
	  
	  #______ EN COURS ACTUELLEMENT ______________
      @mes_abonnements_encours = []
      
      @today = Date.today #return aaaa-mm-jj
      if @mes_paniers.count > 0
	      @mes_paniers.each do |panier|
	           @some_abonnement = Abonnement.where('panier_id = ? AND etat = "paye" AND date_fin >= ?',panier.id,@today)
	           
	           if @some_abonnement.count > 0
	               @some_abonnement.each do |abonnement|
	                   @mes_abonnements_encours.push(abonnement)
	               end 
	           end
	      end
	  end
	  
	  
	  #______ ABONNEMENT TERMINE ___________________
      @mes_abonnements_termine = []
      
      @today = Date.today #return aaaa-mm-jj
      if @mes_paniers.count > 0
	      @mes_paniers.each do |panier|
	           @some_abonnement = Abonnement.where('panier_id = ? AND etat = "paye" AND date_fin < ?',panier.id,@today)
	           
	           if @some_abonnement.count > 0
	               @some_abonnement.each do |abonnement|
	                   @mes_abonnements_termine.push(abonnement)
	               end 
	           end
	      end
	  end
	  
	  
	  #_____ ABONNEMENT ANNULEE AVANT SOUSCRIPTON _________
      @mes_abonnements_annule = []
      
      @today = Date.today #return aaaa-mm-jj
      if @mes_paniers.count > 0
	      @mes_paniers.each do |panier|
	           @some_abonnement = Abonnement.where('panier_id = ? AND etat = "annule"',panier.id)
	           
	           if @some_abonnement.count > 0
	               @some_abonnement.each do |abonnement|
	                   @mes_abonnements_annule.push(abonnement)
	               end 
	           end
	      end
	  end
  end

  #_____ SHOW ABONNEMENTS ____
  def show
  end
  
  

end
