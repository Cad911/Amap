class PointRelai < ActiveRecord::Base
	belongs_to :user
	belongs_to :ville
end