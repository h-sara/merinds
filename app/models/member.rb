class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      memberuser.first_name = "guest"
      memberuser.last_name = "member"
      memberuser.first_name_kana = "ゲスト"
      memberuser.last_name_kana = "メンバー"
      memberuser.nickname = "merindsゲスト"
    end
  end
end
