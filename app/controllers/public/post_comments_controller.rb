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
      redirect_to my_post_path(@post_show)
    else
      render "public/posts/show"
    end
  end

  def create_your
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
      redirect_to your_post_path(@post_show)
    else
      render "public/posts/show_your"
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    # 投稿が現メンバーのものかどうかで遷移先を変更する
    if comment.post.member_id == current_member.id
      redirect_to my_post_path(comment.post_id)
    else
      redirect_to your_post_path(comment.post_id)
    end
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
