class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    if @comment.save

      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Comment added successfully'
    else
      flash.now[:alert] = @post.errors.full_messages.first if @post.errors.any?
    render :new, status: 400
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
