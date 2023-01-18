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
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
  end

  def create #投稿作成
    @post = Post.new(post_params)
    @post.save
    redirect_to my_post_path(@post.id)
  end

  def edit
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
  end

  def update
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # 現メンバー情報を@memberに格納
    if @post_show.update(post_params)
      # 編集した場合、is_editedカラムをtrueにする
      @post_show.update(is_edited: true)
      redirect_to my_post_path(@post_show)
    else
      render :edit
    end
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