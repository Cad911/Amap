class Article < ActiveRecord::Base
	belongs_to :categorie_blog

	def get_categorie_principal
		@categorie = CategorieBlog.find(self.categorie_blog_id)
		if @categorie.categorie_blog_id != 0 && @categorie.categorie_blog_id == "NULL"
			@categorie_principal = CategorieBlog.find(@categorie.categorie_blog_id)
		else
			@categorie_principal = @categorie
		end
		
		return @categorie_principal
		
	end
	
	def get_sous_categorie
		
	end
end
