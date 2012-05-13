class PhotoStock < ActiveRecord::Base
  belongs_to :stock
  
  mount_uploader :image, ImageUploader
end
