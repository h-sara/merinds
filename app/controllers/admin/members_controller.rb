class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  def show
    # 選択したメンバー情報を@memberに格納
    @member = Member.find(params[:id])
    # 現メンバーがいいねした投稿のidをfavoritesに格納
    favorites = Favorite.where(member_id: params[:id]).pluck(:post_id)
    # 現メンバーがいいねした投稿の情報を取り出して@favorite_postsに格納
    @favorite_posts = Post.find(favorites)
  end

  def edit
    @member_edit = Member.find(params[:id])
    # 選択したメンバー情報を@memberに格納
    @member = Member.find(params[:id])
  end

  def update
    # 選択したメンバー情報をmemberに格納
    @member = Member.find(params[:id])
    # 選択したメンバー情報をmember_paramsにある該当するカラムを更新する
    if @member.update(member_params)
      # updateに成功した場合
      redirect_to admin_member_path(@member.id)
    else
      @member_edit = Member.find(params[:id])
      # updateに失敗した場合
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(
      :member_image,
      :email,
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
