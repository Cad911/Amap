class AbonnementsController < InheritedResources::Base

  def Sabonner
  	@date_debut = Date.current
  	
  	@abonnement = Abonnement.new
  	@abonnement.client_id = current_client.id
  	@abonnement.panier_id = params[:panier_id]
  	@abonnement.duree = params[:duree] #EN MOIS
  	@abonnement.date_debut = @date_debut
  	@abonnement.date_end = @date.months_since(params[:duree])
  	
  	@abonnement.save
  end
end
