# moduleを定義
module CommonActions
  #インクルード先で、クラスメソッドも使用することができる。
  extend ActiveSupport::Concern

  # 左側画面に必要な変数等を記述
  def left_screen_variables
    # 現メンバー情報をDBから取り出し、@member_for_leftに格納
    @member_for_left = Member.find(current_member.id)
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # favoritesに格納された投稿IDで街頭の投稿を呼び出し、@favorite_postsに格納（ステータス：表示・10個ずつでページネーション）
    @favorite_posts = Post.where(id: favorites, is_hidden: false).page(params[:page]).per(10)
    # 投稿数の表示
    @member_posts = Post.where(member_id: @member_for_left.id, is_hidden: false)
  end

  # 繰り返し使用する変数等を記述
  def repeat_variables
   @member = current_member
  end

end