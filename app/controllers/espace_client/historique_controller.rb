class EspaceClient::HistoriqueController < InheritedResources::Base
	#load_and_authorize_resource
    #skip_load_and_authorize_resource :only => :emailExist
	layout 'espace_client'
	

	def index
		@client = Client.find(current_client.id)
		@abonnements_en_cours = @client.mes_abonnements_en_cours
		@abonnements_termines = @client.mes_abonnements_termines
	end
	
	
end
