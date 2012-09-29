class Administration::CategorieController < ApplicationController

	def get_all_categorie
	  @categorie = Categorie.all()
      respond_to do |format|
  		format.json { render :json => @categorie
  		}
  	end 
	end
end
