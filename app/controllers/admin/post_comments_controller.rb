class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  def show
    # 選択したコメントの情報を@post_commentに格納
    @post_comment = PostComment.find(params[:id])
  end

  def edit
    # 選択したコメントの情報を@post_commentに格納
    @post_comment = PostComment.find(params[:id])
    # 選択したメンバー情報を@memberに格納
    @member = Member.pluck(:nickname, :id)
  end

  def update
    # 選択したコメントの情報をpost_commentに格納
    post_comment = PostComment.find(params[:id])
    # 選択したコメントの情報をpost_comment_paramsにある該当するカラムを更新する
    if post_comment.update(post_comment_params)
      # updateに成功した場合
      redirect_to admin_post_post_comment_path(post_comment.id)
    else
      # updateに失敗した場合
      render :edit
    end
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(
      :member_id,
      :post_id,
      :comment,
      :is_hidden
    )
  end
end
