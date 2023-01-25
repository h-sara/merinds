class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, only: [:top, :about]
  def top
    # 全てのメンバー情報を取り出し、1ページ10個表示させる
    @members = Member.page(params[:page]).per(10)
  end
end
