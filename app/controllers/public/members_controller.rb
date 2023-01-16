class Public::MembersController < ApplicationController
  def top
  end

  def index
  end

  def show
    # 現メンバー == current_member
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
    # 投稿の作成
    @post = Post.new
    # # 現メンバーのフォロー情報を@followingsに追加
    # @followings = @member.followings
    # # 現メンバーのフォロワー情報を@followingsに追加
    # @followings = @member.followings
  end

  def show_your
  end

  def edit
  end

  def update
  end

  def check
  end

  def withdraw
  end

  private

  def member_params
    params.require(:member).permit(
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
