class Public::FavoritesController < ApplicationController
  before_action :ensure_guest_user

  #モジュールをincludeする
  include CommonActions

  def index
    left_screen_variables
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # favoritesに格納された投稿IDで街頭の投稿を呼び出し、@favorite_postsに格納（ステータス：表示・10個ずつでページネーション）
    @favorite_posts = Post.where(id: favorites, is_hidden: false).page(params[:page]).per(10)
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

  private
  def ensure_guest_user
    if current_member.nickname == "merindsゲスト"
      flash[:notice] = "そのページには遷移できません。"
      redirect_to your_posts_path
    end
  end
end
