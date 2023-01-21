class Public::SearchesController < ApplicationController
  def search
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
    

    # 選択された検索対象を@select_modelに格納する
    @select_model = params[:select_model]

    if @select_model == "メンバー"
      # 選択された検索対象がメンバーだった場合
      @members = Member.looks(params[:word])
      # 検索がHITしなかった場合
      if @members == nil
        @members = 0
      end
    else
      # 選択された検索対象がメンバー以外だった場合
      @posts = Post.looks(params[:word])
      # 検索がHITしなかった場合
      if @posts == nil
        @posts = 0
      end
    end
  end
end
