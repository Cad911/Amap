class CageotsController < InheritedResources::Base

	def ajoutCageot
		@cageot = Cageot.where( :etat => 'en_cours') #SI CAGEOT EN COURS
		
		#SI_CAGEOT_EN_COURS
		if @cageot.count > 0
		
		else
		#SINON_CREATION_CAGEOT
		
		end
	end
end
