class Admin::PostCommentsController < ApplicationController
  def show
    @post_comment = PostComment.find(params[:id])
  end

  def edit
  end

  def update
  end
end
