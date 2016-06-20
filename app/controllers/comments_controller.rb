class CommentsController < ApplicationController





  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment))
    # if @comment.user_id = current_user.id
      # if current_user
    if @comment.comment.present?
      @comment.user = current_user
      flash[:notice] = "Comment Posted!"
      @comment.save
      redirect_to post_path(@post)
    else
      flash[:notice] = " Cannot Post Empty Comment !"

      # render 'new'
      redirect_to post_path(@post)
    end



    # if @comment.save
    #   flash[:notice] = "Comment Posted!"


  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

  if @comment.user_id == current_user.id
    # @comment.update_attributes(....)
      flash[:notice] = "Update Comments Here"
    # redirect_to edit_post_comment_path
     render 'edit'
    # (@post)
  else
     flash[:notice] = "Sorry, it's not your comment"
     redirect_to post_path(@post)
  end


  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy

     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
     #if current_user

     flash[:notice] = 'Post deleted successfully'
     @comment.destroy

     redirect_to post_path(@post )
   else
    flash[:notice] = "Sorry, it's not your comment"
    redirect_to post_path(@post)


    end
  end

end
