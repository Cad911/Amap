class Administration::UniteMesuresController < InheritedResources::Base
  def get_unite_mesure
      @unite_mesure = UniteMesure.all()
      respond_to do |format|
  		format.json { render :json => @unite_mesure
  		}
  	end 
  
  end
end
