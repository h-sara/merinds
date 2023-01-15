class Member < ApplicationRecord
  has_one_attached :member_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  # メンバーのアイコン画像の設定
  def get_member_image(width, height)
    unless member_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      member_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # member_image.variant(resize_to_fill: [width, height]).processed
  end

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
