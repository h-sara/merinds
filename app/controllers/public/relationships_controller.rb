class Public::RelationshipsController < ApplicationController
  #モジュールをincludeする
  include CommonActions

  def create # フォローする時の処理
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy # フォロー解除する時の処理
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def followings # フォロー一覧
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    #includeしたインスタンスメソッドを使用
    repeat_variables
    
    # 現メンバーのフォロー情報を@followingsに格納
    @followings = current_member.followings
  end

  def followers # フォロワー一覧
    #includeしたインスタンスメソッドを使用
    left_screen_variables
    #includeしたインスタンスメソッドを使用
    repeat_variables
    
    # 現メンバーのフォロワー情報を@followersに格納
    @followers = current_member.followers
  end
end
