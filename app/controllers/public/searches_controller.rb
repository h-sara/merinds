class Public::SearchesController < ApplicationController
  #モジュールをincludeする
  include CommonActions

  def search
    #includeしたインスタンスメソッドを使用
    left_screen_variables

    # 選択された検索対象を@select_modelに格納する
    @select_model = params[:select_model]

    if @select_model == "メンバー"
      # 選択された検索対象がメンバーだった場合
      @members = Member.looks(params[:word])
      # 検索がHITしなかった場合
      if @members == nil
        @members = 0
      end
    else
      # 選択された検索対象がメンバー以外だった場合
      @posts = Post.looks(params[:word])
      # 検索がHITしなかった場合
      if @posts == nil
        @posts = 0
      end
    end
  end
end
