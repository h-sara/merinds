class Post < ApplicationRecord
  has_one_attached :image_id
  belongs_to :member, optional: true
  has_many :post_comments, dependent: :destroy

  # 投稿の添付画像の設定
  # def get_post_image(width, height)
  #   unless post_image.attached?
  #     post_image =
  #   end
  #   post_image.variant(resize_to_fill: [width, height]).processed
  # end
end
