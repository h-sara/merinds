class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :post

  # バリデーションの設定
  ## コメント内容（必須・300文字まで）
  validates :comment, presence: true, length: { maximum: 300 }
end
