class Post < ApplicationRecord
  has_one_attached :image_id
  belongs_to :member, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 投稿検索のためのメソッド
  def self.looks(word)
    #部分一致で検索
    @post = Post.where("sentence LIKE ?", "%#{word}%")
  end
  
  # 引数で渡されたメンバーidがfavoritesテーブル内に存在するかどうかを調べるためのメソッド
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  # 投稿の添付画像の設定
  # def get_post_image(width, height)
  #   unless post_image.attached?
  #     post_image =
  #   end
  #   post_image.variant(resize_to_fill: [width, height]).processed
  # end
end
