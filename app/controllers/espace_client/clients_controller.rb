class EspaceClient::ClientsController < InheritedResources::Base
	load_and_authorize_resource
	layout 'espace_client'
	
end
