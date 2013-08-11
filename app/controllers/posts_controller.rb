class PostsController < ApplicationController
	  layout "admin", :only => [:new, :edit, :admin, :show]
  
  	prepend_before_filter do
      params[:post] &&= post_params
    end

    load_and_authorize_resource     

  	def index
		  @posts = Post.order("created_at desc").page(params[:page]).per_page(ENV['posts_per_page'].to_f)
      
      respond_to do |format|
        format.html {  render :layout => "application"} # index.html.erb
        format.js
       
      end

  	end   
  
   	def all
    	@posts = Post.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  	end

  	def new
    	@post = Post.new
  	end

  	def show
    	@post = Post.find(params[:id])
    	if request.path != post_path(@post)
      		redirect_to @post, status: :moved_permanently
    	end

  	end
  
  	def edit
   		@post = Post.find(params[:id])
  	end

  	def create
    	@post = Post.new(post_params)

    	respond_to do |format|
      		if @post.save
        		format.html { redirect_to admin_path, notice: "Post was saved" }
      		else
        		format.html { render action: "new" }
        		format.json { render json: @post.errors, status: :unprocessable_entity }
      		end
    	end
  	end
  
  	def update
    	@post = Post.find(params[:id])

    	respond_to do |format|
      		if @post.update_attributes(post_params)
        		format.html { redirect_to post_path, notice: "Post was saved" }
      		else
        		format.html { render action: "edit" }
        		format.json { render json: @post.errors, status: :unprocessable_entity }
      		end
    	end
  	end

  
  	def destroy
    	@post = Post.find(params[:id]).delete
    	redirect_to admin_path, :notice => "Post has been deleted." 
   
  	end

    private
    def post_params
      params.require(:post).permit(:title, :content, :media)
    end

end
