class Cageot < ActiveRecord::Base
  belongs_to :client
  
  has_many :rel_cageot_produits
  has_one :commande
end
