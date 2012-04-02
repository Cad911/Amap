class PanierAutorise < ActiveRecord::Base
	belongs_to :user
	belongs_to :categorie
	
	has_many :paniers
end
