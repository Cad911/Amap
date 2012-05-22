class PhotoPanier < ActiveRecord::Base
  belongs_to :panier
  
  mount_uploader :image, ImageUploader
end
