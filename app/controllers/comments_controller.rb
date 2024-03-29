class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_post, only: %i[new create update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(user_id: @post.author.id, id: @post.id), notice: 'Comment added successfully'
    else
      flash.now[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :new, status: 400
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    authorize! :update, @comment

    if @comment.update(comment_params)
      redirect_to user_post_path(user_id: @comment.post.author.id, id: @comment.post.id),
                  notice: 'Comment updated successfully'
    else
      flash.now[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :edit, status: 400
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(user_id: current_user.id, id: @comment.post_id), notice: 'Comment deleted successfully'
    else
      flash.new[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :show, status: 400
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
