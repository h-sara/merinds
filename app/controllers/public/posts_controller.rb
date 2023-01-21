class Public::PostsController < ApplicationController

  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    
    # 現メンバーが投稿した投稿情報を@postsに格納
    @posts = Post.where(member_id: @member.id)
  end

  def show
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # コメントの作成
    @post_comment = PostComment.new
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
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    
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
    # 選択した投稿の情報をpostに格納
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_posts_path, notice: "投稿の削除を実行しました。"
  end

  def index_your
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    
    # すべての投稿を@postsに格納
    @posts = Post.all
    # binding.pry
  end

  def show_your
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # コメントの作成
    @post_comment = PostComment.new
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