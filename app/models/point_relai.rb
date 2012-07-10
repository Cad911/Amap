class PointRelai < ActiveRecord::Base
	belongs_to :user
	belongs_to :ville
	
	has_many :commandes
	has_many :abonnements
end
