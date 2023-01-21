class Public::RelationshipsController < ApplicationController

  def create # フォロー時
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy # フォロー解除時
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def followings # フォロー一覧
    member.find
  end

  def followers # フォロワー一覧
    
  end
end
