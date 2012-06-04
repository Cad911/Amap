class SessionsController < Devise::SessionsController
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => :failure)
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {
    				:success => true, 
    				:message => "Bien le bonjour #{resource.nom}" ,
    				:user => resource,
    				:redirect => stored_location_for(scope) || after_sign_in_path_for(resource),
    				:link => {
    					:mes_infos => espace_client_client_path(resource.id),
    					:deconnexion => client_logout_path(),
    				}
    		}
  end

  def failure
    return render:json => {:success => false, :errors => ["Login failed."]}
  end
end
