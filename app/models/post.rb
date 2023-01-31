class Post < ApplicationRecord
  has_one_attached :image_id
  belongs_to :member, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  # バリデーションの設定
  ## 投稿内容（必須・300文字まで）
  validates :sentence, presence: true, length: { maximum: 300 }



  # 投稿検索のためのメソッド
  def self.looks(word)
    #部分一致で検索
    @post = Post.where("sentence LIKE ?", "%#{word}%")
  end

  # 引数で渡されたメンバーidがfavoritesテーブル内に存在するかどうかを調べるためのメソッド
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
