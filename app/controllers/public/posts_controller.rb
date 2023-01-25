class Public::PostsController < ApplicationController
  #モジュールをincludeする
  include CommonActions

  def index
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    #includeしたインスタンスメソッドを使用
    repeat_variables

    # 現メンバーが投稿した非表示ではない投稿情報を作成順に@postsに格納（10個ずつでページネーション）
    @posts = Post.where(member_id: @member.id, is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    #includeしたインスタンスメソッドを使用
    repeat_variables

    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # コメントの作成
    @post_comment = PostComment.new
  end

  def create #投稿作成
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    #includeしたインスタンスメソッドを使用
    repeat_variables
    @post = Post.new(post_params)
    if @post.save
      redirect_to my_post_path(@post.id), notice: "投稿に成功しました。"
    else
      # 現メンバーが投稿した非表示ではない投稿情報を作成順に@postsに格納（10個ずつでページネーション）
      @posts = Post.where(member_id: @member.id, is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
      render :index
    end
  end

  def edit
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
  end

  def update
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # 現メンバー情報を@memberに格納
    if @post_show.update(post_params)
      # 編集した場合、is_editedカラムをtrueにする
      @post_show.update(is_edited: true)
      redirect_to my_post_path(@post_show)
    else
      render :edit
    end
  end

  def destroy
    # 選択した投稿の情報をpostに格納
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_posts_path, notice: "投稿の削除を実行しました。"
  end

  def index_your
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    # すべての投稿を@postsに格納
    @posts = Post.where(is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show_your
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # コメントの作成
    @post_comment = PostComment.new
  end

  private

  def post_params
    params.require(:post).permit(
      :member_id,
      :sentence,
      :image_id,
      :is_edited,
      :is_hidden).merge(member_id: current_member.id)
  end

end