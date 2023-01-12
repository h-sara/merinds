class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      # カラムを追加
      ## メンバーID／integer型／NOTNULL
      t.integer :member_id, null: false
      ## 投稿ID／integer型／NOTNULL
      t.integer :post_id, null: false
      ## コメント内容／text型／NOTNULL
      t.text :comment, null: false
      ## 非表示フラグ／boolean型／NOTNULL／default:false
      t.boolean :is_hidden, null: false, default: false

      t.timestamps
    end
  end
end
