class Administration::BlogController < ApplicationController
  protect_from_forgery :except => [:upload_image]
  
  
  #----------------------------------------------------------
  #----------------------------------------------------------
  #---------------------- CATEGORIE -------------------------
  #----------------------------------------------------------
  #----------------------------------------------------------
  def index_categorie
  end
  
  def new_categorie
  end
  
  
  def create_categorie
  
  end
  
  #----------------------------------------------------------
  #----------------------------------------------------------
  #----------------------- ARTICLE --------------------------
  #----------------------------------------------------------
  #----------------------------------------------------------
  def index_article
  	@articles = Article.all
  	render :index
  end
  
  def new_article
  	
  end
  
  
  def create_article
  	@article = Article.new(params[:article])
  	
  	@article.save
  	
  	redirect_to administration_user_blog_index_path(current_user.id)
  end
  
  
  def edit_article
  	@article = Article.find(params[:article_id])
  end
  
  def update_article
  	@article = Article.find(params[:article_id])
  	
  	@article.update_attributes(params[:article])
  	
  	redirect_to administration_user_edit_article_path(current_user.id)
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
