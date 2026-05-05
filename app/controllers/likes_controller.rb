class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)
    
    if @like.save
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post: @post)
    
    if @like&.destroy
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end
end
