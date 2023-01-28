class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
  end
end
