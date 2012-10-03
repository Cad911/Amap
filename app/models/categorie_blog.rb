class CategorieBlog < ActiveRecord::Base
	has_many :articles
	
	
	
	def all_categorie_maitre
		@categorie = CategorieBlog.where('categorie_blog_id = 0')
		
		if @categorie.count > 0
			return @categorie
		else
			return false
		end
	end
	
	
	
	def sous_categorie
		@sous_categorie = CategorieBlog.where('categorie_blog_id = ?', self.id)
		
		if @sous_categorie.count > 0
			return @sous_categorie
		else
			return false
		end
	end
end
