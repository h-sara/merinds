class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ゲストログインに使用するguestメソッドを定義
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.first_name = "guest"
      member.last_name = "member"
      member.first_name_kana = "ゲスト"
      member.last_name_kana = "メンバー"
      member.nickname = "merindsゲスト"
    end
  end
end
