class Administration::CommandesController < ApplicationController
  
  #_____ INDEX ____
  def index
      @mes_commandes_paye = []
      
      #__RECHERCHE TOUTES LES COMMANDES PAYE
      @commandes_paye = Commande.where("etat = 'paye'")
      
      @commandes_paye.each do |commande|
         (commande.rel_commande_produits).each do |produit_commande|
             #__ ON RECUPERE SEULEMENt LES PRODUITS CORRESPONDANT A l'UTILISATEUR
             if produit_commande.user == current_user
                 @mes_commandes_paye.push(produit_commande)
             end
         end
      end
      
      
      #___ COMMANDE ANNULEE AVANT PAIEMENT DU CLIENT _____
      @mes_commandes_annule = []
      
      @commandes_annule = Commande.where("etat = 'annule'")
      @commandes_annule.each do |commande|
         (commande.rel_commande_produits).each do |produit_commande|
             #__ ON RECUPERE SEULEMENt LES PRODUITS CORRESPONDANT A l'UTILISATEUR
             if produit_commande.user == current_user
                 @mes_commandes_annule.push(produit_commande)
             end
         end
      end
      
      
      #___ COMMANDE EN COURS _____
      @mes_commandes_encours = []
      
      @commandes_encours = Commande.where("etat = 'en_cours'")
      @commandes_encours.each do |commande|
         (commande.rel_commande_produits).each do |produit_commande|
             #__ ON RECUPERE SEULEMENt LES PRODUITS CORRESPONDANT A l'UTILISATEUR
             if produit_commande.user == current_user
                 @mes_commandes_encours.push(produit_commande)
             end
         end
      end
      
  end
  
  
end
