class Post < ApplicationRecord
  belongs_to :member, optional: true
  has_many :post_comments, dependent: :destroy

  # 投稿の添付画像の設定
  def get_post_image(width, height)
    post_image.variant(resize_to_fill: [width, height]).processed
  end
end
