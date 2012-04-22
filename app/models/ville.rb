class Ville < ActiveRecord::Base
	belongs_to :region
	
	has_many :users
	has_many :point_relais
end
