class Public::HomesController < ApplicationController
  # ログインしていないメンバーへの制限
  ## トップページ・アバウトページのみ可
  before_action :authenticate_member!, except: [:top, :about]

  def top
  end

  def about
  end
end
