class VillesController < ApplicationController
  
  def index
  	@villes = Ville.all()
  	respond_to do |format|
  		format.json { render :json => {
  						:ville => @villes,
  					} 	
  		}
  		format.html { render :nothing => true }
  	end

  end

end

