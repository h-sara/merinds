class Admin::MembersController < ApplicationController
  def show
    # 選択したメンバー情報を@memberに格納
    @member = Member.find(params[:id])
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: params[:id]).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
  end

  def edit
  end

  def update
  end
end
