require 'jwt'

class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource

  before_action :find_post, only: %i[index create]

  def index
    if @post
      @comments = Comment.where(post_id: params[:post_id])
      render json: { status: 'Success', data: @comments }
    else
      render json: { status: 'Failure', error: 'Post Not Found' }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @auth_user
    @comment.post = @post

    if @comment.save
      render json: { status: 'Success', data: @comment }
    else
      render json: { status: 'Failure', error: @comment.errors.full_messages }
    end
  end

  private

  def find_post
    @post = Post.find_by_id(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
