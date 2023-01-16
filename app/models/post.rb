class Post < ApplicationRecord

  # 投稿の添付画像の設定
  def get_post_image(width, height)
    post_image.variant(resize_to_fill: [width, height]).processed
  end
end
