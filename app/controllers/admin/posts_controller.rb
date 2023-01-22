class Admin::PostsController < ApplicationController
  def index
    # 全ての投稿情報を取り出し、1ページ10個表示させる
    @posts = Post.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end
end
