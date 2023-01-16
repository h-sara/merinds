class PostComment < ApplicationRecord
  belongs_to :members
  belongs_to :posts
end
