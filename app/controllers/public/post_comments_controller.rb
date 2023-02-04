class Public::PostCommentsController < ApplicationController
  before_action :ensure_guest_user

  #モジュールをincludeする
  include CommonActions

  def create
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    repeat_variables
    # コメントの作成
    @post_comment = PostComment.new
    @post_show = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    # 投稿idをコメントのpost_idに格納
    @post_comment.post_id = @post_show.id
    if @post_comment.save
      flash[:notice] = "コメントの投稿に成功しました"
      # render先にjsファイルを指定
      render "public/post_comments/post_comments"
    else
      flash[:notice] = "コメントの投稿に失敗しました"
      render "public/posts/show"
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    # renderした際に使用
    @post_show = Post.find(params[:post_id])
    # render先にjsファイルを指定
    render "public/post_comments/post_comments"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(
      :member_id,
      :comment).merge(member_id: current_member.id)
  end

  def ensure_guest_user
    if current_member.nickname == "merindsゲスト"
      flash[:notice] = "そのページには遷移できません。"
      redirect_to your_posts_path
    end
  end
end
