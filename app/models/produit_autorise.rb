class ProduitAutorise < ActiveRecord::Base
	belongs_to :user
	belongs_to :categorie
	
	has_many :stocks
end
