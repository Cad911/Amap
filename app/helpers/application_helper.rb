module ApplicationHelper
    
    
    def product_cageot
    	if current_client.nil?
			@select_cageot = Cageot.where("etat='en_cours' AND session_id = ?", session[:cageot_id])
		else
			@select_cageot = Cageot.where("etat='en_cours' AND client_id = ?", current_client.id) #SI CAGEOT EN COURS
		end
		
		if @select_cageot.count > 0
			@cageot = Cageot.find(@select_cageot[0].id)
			tab_total = ((@cageot.total).to_s).split('.')
			@total_cageot = @cageot.total
			#VERIF SI APRES LA VIRGULE, C'EST UN 0 OU PAS
			if tab_total[1]
			   if tab_total[1].to_i == 0
			       @total_cageot = tab_total[0]
			   end
			end
			@product_cageot =  RelCageotProduit.where("cageot_id = ? ",@cageot.id).order('created_at DESC')
		else
			@cageot = nil
			@product_cageot = []
		end
    end
    
    def breadcrumb
    	
    end
end
