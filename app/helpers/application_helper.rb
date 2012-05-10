module ApplicationHelper
    
    
    def product_cageot
    	if current_client.nil?
			@select_cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:cageot_id])
		else
			@select_cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
		end
		
		if @select_cageot.count > 0
			@cageot = Cageot.find(@select_cageot[0].id)
			@product_cageot =  RelCageotProduit.where("cageot_id = ? ",@cageot.id).order('created_at DESC')
		else
			@cageot = nil
		end
		
    end
end
