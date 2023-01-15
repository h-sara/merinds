class Public::MembersController < ApplicationController
  def top
  end

  def index
  end

  def show
    @member = current_member
  end

  def show_your
  end

  def edit
  end

  def update
  end

  def check
  end

  def withdraw
  end

  private

  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :first_name_kana,
      :last_name_kana,
      :nickname,
      :introduction,
      :is_deleted,
    )
  end
end
