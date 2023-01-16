class Public::MembersController < ApplicationController

  # 現メンバー == current_member
  def top
  end

  def index
    # 現メンバー情報を@memberに格納
    @member = current_member
    # 現メンバーの投稿情報を@postsに格納
    @posts = Post.where(member_id: "current_member.id")
    # # 投稿の作成
    @post = Post.new
    # ゲストメンバー以外のメンバー情報を全て格納
    @members = Member.where.not(email: "guest@example.com")
    @show_your = @members.find_by(params[:nickname])
    binding.pry
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
