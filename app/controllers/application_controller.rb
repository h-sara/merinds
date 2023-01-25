class ApplicationController < ActionController::Base
  # ログインしていないメンバーへの制限
  ## トップページ・アバウトページのみ可
  before_action :authenticate_member!, except: [:top, :about]
end