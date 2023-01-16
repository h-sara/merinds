class Relationship < ApplicationRecord
  # class_name: "Member"で、memberモデルを参照
  belongs_to :follower, class_name: "Member"
  belongs_to :followed, class_name: "Member"
end