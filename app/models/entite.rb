class Entite < ActiveRecord::Base
	belongs_to :droit
	
	has_many :users
end
