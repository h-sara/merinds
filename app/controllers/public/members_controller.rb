class Public::MembersController < ApplicationController

  # 現メンバー == current_member
  def top
  end

  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
    # 投稿の作成
    @post = Post.new
    # ゲスト、退会済み以外のメンバーのレコードをすべて取得
    @members = Member.where.not("email = ? or is_deleted = ?", "guest@example.com", true)
  end

  def show
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
    # 投稿の作成
    @post = Post.new
  end

  def show_your
  end

  def edit
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
    # # 投稿の作成
    @post = Post.new
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
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
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
      :is_deleted,
    )
  end
end
