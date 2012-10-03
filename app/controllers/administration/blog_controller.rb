class Administration::BlogController < ApplicationController
  protect_from_forgery :except => [:upload_image]
  
  
  #----------------------------------------------------------
  #----------------------------------------------------------
  #---------------------- CATEGORIE -------------------------
  #----------------------------------------------------------
  #----------------------------------------------------------
  def index_categorie
  	@categorie_blogs = CategorieBlog.where('categorie_blog_id = 0')
  end
  
  def new_categorie
  	@categorie_blog = CategorieBlog.new
  	
  	render :new_categorie
  end
  
  def create_categorie
  	@categorie_blog = CategorieBlog.new(params[:categorie_blog])
  	  	if @categorie_blog.categorie_blog_id.nil?
  	  		@categorie_blog.categorie_blog_id = 0
  	  	end
  	@categorie_blog.user_id = current_user.id
  	@categorie_blog.deleted = 0
  	@categorie_blog.save
  	
  	redirect_to administration_user_index_categorie_path(current_user.id)
  end
  
  def update_categorie
  	@categorie_blog = CategorieBlog.find(params[:categorie_blog_id])
  	
  	render :update_categorie
  end
  
  def edit_categorie
  	@categorie_blog = CategorieBlog.find(params[:categorie_blog_id])
  	@categorie_blog.update_attributes(params[:categorie_blog])
  	
  	render :update_categorie
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
