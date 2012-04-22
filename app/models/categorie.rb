class Categorie < ActiveRecord::Base
  has_many :produit_autorises
  has_many :panier_autorises
  has_many :stocks
  has_many :paniers
end
