class Public::PostsController < ApplicationController

  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 選択したメンバーの情報を@postsに格納
    @posts = Post.where(params[:id])
  end

  def show
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new

    @post_show = Post.find(params[:id])
  end

  def create #投稿作成
    @post = Post.new(post_params)
    @post.save
    redirect_to my_post_path(@post.id)
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
      :member_id,
      :sentence,
      :image_id,
      :is_edited,
      :is_hidden).merge(member_id: current_member.id)
  end

end