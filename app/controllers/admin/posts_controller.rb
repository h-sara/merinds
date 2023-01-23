class Admin::PostsController < ApplicationController
  def index
    # 全ての投稿情報を取り出し、1ページ10個表示させる
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    # 選択した投稿の情報を@postに格納
    @post = Post.find(params[:id])
    # 選択した投稿のidとpost_idが一致するすべてのコメントを@post_commentsに格納
    @post_comments = PostComment.where(post_id: @post.id)
  end

  def edit
    # 選択した投稿の情報を@postに格納
    @post = Post.find(params[:id])
    # 選択したメンバー情報を@memberに格納
    @member = Member.pluck(:nickname, :id)
  end

  def update
    # 選択した投稿の情報を@postに格納
    post = Post.find(params[:id])
    # 選択した投稿の情報をpost_paramsにある該当するカラムを更新する
    if post.update(post_params)
      # updateに成功した場合
      redirect_to admin_post_path(post.id)
    else
      # updateに失敗した場合
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :member_id,
      :sentence,
      :image_id,
      :is_edited,
      :is_hidden
    )
  end
end
