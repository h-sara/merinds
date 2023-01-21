class Public::FavoritesController < ApplicationController

  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new

    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
  end

  def create
    post = Post.find(params[:post_id])
    # 現メンバーのいいねを投稿idを元にインスタンス作成した情報をfavoriteに格納
    favorite = current_member.favorites.new(post_id: post.id)
    # 作成したインスタンスを保存する
    favorite.save
    # 直前のページにリダイレクトする
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    # 現メンバーのいいねを投稿idを元に作成されたインスタンス情報をfavoriteに格納
    favorite = current_member.favorites.find_by(post_id: post.id)
    # 作成されたインスタンスを削除
    favorite.destroy
    # 直前のページにリダイレクトする
    redirect_back(fallback_location: root_path)
  end
end
