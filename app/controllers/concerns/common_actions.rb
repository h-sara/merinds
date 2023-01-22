# moduleを定義
module CommonActions
  #インクルード先で、クラスメソッドも使用することができる。
  extend ActiveSupport::Concern

  # 左側画面に必要な変数等を記述
  def left_screen_variables
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
  end

end