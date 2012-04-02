class ProduitPanier < ActiveRecord::Base
	belongs_to :panier
	belongs_to :stock
end

