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
  end

  def update
  end
end
