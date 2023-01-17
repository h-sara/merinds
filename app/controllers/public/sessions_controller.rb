# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  #サインイン後の遷移先
  def after_sign_in_path_for(resource)
    my_page_path
  end

  # ゲストログイン機能
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to your_posts_path, notice: 'ゲストでログインしました。'
  end

  protected
  # 退会しているか判断するメソッド
  def member_state
    # 入力されたemaiからアカウントを1件取得
    @member = Member.find_by(email: params[:member][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@member
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @member.valid_password?(params[:member][:password])
      # 取得したアカウントのis_deletedカラムがtrueだった場合、
      ## 退会しているためサインアップ画面に遷移する
      if @member.is_deleted == true
        redirect_to new_member_registration_path, notice: "退会済みメンバーです。再度ご登録をしてご利用ください。"
      end
    end
  end
end
