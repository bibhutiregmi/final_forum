class ProfileController < ApplicationController

def index
	 @posts = current_user.posts.order("created_at DESC")

end

def show
	@posts = current_user.posts.order("created_at DESC")

end





end
