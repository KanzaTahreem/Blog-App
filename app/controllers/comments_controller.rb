class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    respond_to do |_format|
      if @comment.save

        redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
      else
        render :new
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
