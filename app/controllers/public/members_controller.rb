class Public::MembersController < ApplicationController

  # 現メンバー == current_member
  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)

    # ゲスト、退会済み以外のメンバーのレコードをすべて取得
    @members = Member.where.not("email = ? or is_deleted = ?", "guest@example.com", true)
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
  end

  def show_your
    ## 左側画面に必要な変数 ##
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)

    # メンバーのnicknameを取り出して@show_yourに格納
    @show_your = Member.find_by(nickname: params[:nickname])
    # メンバーが投稿者になっている投稿を取り出して@postsに格納
    @posts = Post.find_by(member_id: @show_your.id)
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
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def check
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 投稿の作成
    @post = Post.new
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
  end

  def withdraw
    @member = current_member
    # is_deletedカラムをtrueに変更
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会を実行しました。"
  end

  private

  def member_params
    params.require(:member).permit(
      :member_image,
      :first_name,
      :last_name,
      :first_name_kana,
      :last_name_kana,
      :nickname,
      :introduction,
      :is_deleted
    )
  end
end
