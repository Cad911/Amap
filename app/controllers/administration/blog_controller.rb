class Administration::BlogController < ApplicationController
  protect_from_forgery :except => [:upload_image]
  
  def index
  end
  
  def new_article
  end
  
  
  def upload_image
  	upload_file = params[:image_blog]
  	#upload_file = Base64.encode64(upload_file)
  	path = File.join('public/uploads/blog',upload_file.original_filename)#Rails.root.join('public','uploads','blog','test')
  	File.open(path,'wb') do |file|
  		file.write(upload_file.read)
  	end
  	render :json => {:path => 'http://localhost:3000/uploads/blog/'+upload_file.original_filename}
  end
end
