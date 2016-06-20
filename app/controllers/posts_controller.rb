class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!,except: [:index, :show]




	def index
		@posts = Post.all
  	if params[:search]
    	@posts = Post.search(params[:search]).order("created_at DESC")
  	else
   		@posts = Post.all.order('created_at DESC')
  	end
	end


	def show

	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(find_post)
		if @post.user_id == current_user.id
    # @comment.update_attributes(....)
      flash[:notice] = "Update Your Post Here!!!"
    # redirect_to edit_post_path(@post)
    render 'edit'
    # render edit_post_path(@post)
  	else
     flash[:notice] = "Sorry, it's not your post!!!"
     redirect_to post_path(@post)
	  end
  end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(find_post)

		if @post.user_id == current_user.id
     #if current_user
     @post.destroy
     redirect_to profile_index_path
     flash[:notice] = 'Post deleted successfully'
   else
    flash[:notice] = "Sorry, it's not your post!!! "
    redirect_to post_path(@post)
		# redirect_to root_path
	end
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
