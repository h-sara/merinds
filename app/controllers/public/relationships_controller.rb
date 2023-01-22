class Public::RelationshipsController < ApplicationController

  def create # フォローする時の処理
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy # フォロー解除する時の処理
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def followings # フォロー一覧
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)

    @followings = current_member.followings
  end

  def followers # フォロワー一覧
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)

    @members = current_member.followers
  end
end
