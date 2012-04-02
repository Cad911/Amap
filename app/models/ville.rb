class Ville < ActiveRecord::Base
	belongs_to :region
	has_many :users
end
