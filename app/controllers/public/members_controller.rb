class Public::MembersController < ApplicationController
  #モジュールをincludeする
  include CommonActions

  # 現メンバー == current_member
  def index
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # ゲスト、退会済み以外のメンバーのレコードをすべて取得
    @members = Member.where.not("email = ? or is_deleted = ?", "guest@example.com", true)
  end

  def show
    #includeしたインスタンスメソッドを使用
    left_screen_variables
  end

  def show_your
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # メンバーのnicknameを取り出して@show_yourに格納
    @show_your = Member.find_by(nickname: params[:nickname])
    # メンバーが投稿者になっている投稿を取り出して@your_postに格納
    @your_post = Post.find_by(member_id: @show_your.id)
    # メンバーが投稿者になっている投稿を全て取り出して@postsに格納
    @posts = Post.where(member_id: @show_your.id)
  end

  def edit
    #includeしたインスタンスメソッドを使用
    left_screen_variables
  end

  def update
    member = current_member
    if member.update(member_params)
      flash[:notice] = "編集が完了しました"
      redirect_to my_page_path
    else
      #includeしたインスタンスメソッドを使用
      left_screen_variables
      render :edit
    end
  end

  def check
    #includeしたインスタンスメソッドを使用
    left_screen_variables
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
      :email,
      :nickname,
      :introduction
    )
  end
end
