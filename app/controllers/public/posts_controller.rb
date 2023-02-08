class Public::PostsController < ApplicationController
  before_action :ensure_guest_user, except: [:index_your, :show_your]
  before_action :is_matching_login_member, only: [:destroy]

  #モジュールをincludeする
  include CommonActions

  def index
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    repeat_variables

    # 現メンバーが投稿した非表示ではない投稿情報を作成順に@postsに格納（10個ずつでページネーション）
    @posts = Post.where(member_id: @member.id, is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    repeat_variables

    # 非表示になっている投稿にアクセスしようとした場合
    if post_show = Post.find_by(id: params[:id], is_hidden: true)
      flash[:notice] = "その投稿は表示できません"
      redirect_to my_posts_path
    end
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find_by(id: params[:id], is_hidden: false)

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
      flash[:notice] = "投稿に成功しました"
      redirect_to my_post_path(@post.id)
    else
      # 現メンバーが投稿した非表示ではない投稿情報を作成順に@postsに格納（10個ずつでページネーション）
      @posts = Post.where(member_id: @member.id, is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
      flash[:notice] = "投稿に失敗しました"
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
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find(params[:id])
    # 現メンバー情報を@memberに格納
    if @post_show.update(post_params)
      # 編集した場合、is_editedカラムをtrueにする
      @post_show.update(is_edited: true)
      flash[:notice] = "投稿の編集に成功しました"
      redirect_to my_post_path(@post_show)
    else
      flash[:notice] = "投稿の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    # 選択した投稿の情報をpostに格納
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿の削除を実行しました"
    redirect_to my_posts_path
  end

  def index_your
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    # すべての投稿を@postsに格納（ステータス：表示・最新順・10個ずつでページネーション）
    @posts = Post.where(is_hidden: false).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show_your
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # 非表示になっている投稿にアクセスしようとした場合
    if @post_show = Post.find_by(id: params[:id], is_hidden: true)
      flash[:notice] = "その投稿は表示できません"
      redirect_to your_posts_path
    end
    # 選択した投稿の情報を@post_showに格納
    @post_show = Post.find_by(id: params[:id], is_hidden: false)

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

  def ensure_guest_user
    if current_member.nickname == "merindsゲスト"
      flash[:notice] = "そのページには遷移できません。"
      redirect_to your_posts_path
    end
  end

    # 現メンバーと投稿者が一致するかを判断する
  def is_matching_login_member
    post = Post.find(params[:id])
    # 投稿者と現メンバーが一致しない場合
    unless post.member_id == current_member.id
      flash.now[:notice] = "他ユーザーの投稿は削除できません。"
      redirect_back(fallback_location: root_path)
    end
  end
end