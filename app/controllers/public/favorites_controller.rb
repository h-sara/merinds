class Public::FavoritesController < ApplicationController
  #モジュールをincludeする
  include CommonActions

  def index
    #includeしたインスタンスメソッドを使用
    left_screen_variables
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
