class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    # 投稿idをコメントのpost_idに格納
    comment.post_id = post.id
    comment.save
    # 投稿が現メンバーのものかどうかで遷移先を変更する
    if post.member_id == current_member.id
      redirect_to my_post_path(post)
    else
      redirect_to your_post_path(post)
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
end
