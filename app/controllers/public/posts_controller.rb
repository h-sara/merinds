class Public::PostsController < ApplicationController

  def index
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index_your
  end

  def show_your
  end

  private

  def post_params
    params.require(:post).permit(
      :sentence,
      :image_id,
      :is_edited,
      :is_hidden).merge(member_id: current_member.id)
  end

end