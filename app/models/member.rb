class Member < ApplicationRecord
  has_one_attached :member_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォローした、されたの関係
  has_many :following, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使用する
  has_many :followings, through: :following, source: :followed
  has_many :followers, through: :followed, source: :follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # メンバーのアイコン画像の設定
  def get_member_image(width, height)
    ## アイコン画像がない場合
    unless member_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      member_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    member_image.variant(resize_to_fill: [width, height]).processed
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

  # リンク先指定のため記述
  def to_param
    return nickname
  end

  # メンバー検索のためのメソッド
  def self.looks(word)
    #部分一致で検索
    @member = Member.where("nickname LIKE ?", "%#{word}%")
  end
end
