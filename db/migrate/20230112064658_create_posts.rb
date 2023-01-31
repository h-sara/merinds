class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # カラムを追加
      ## メンバーID／integer型／NOTNULL
      t.integer :member_id, null: false
      ## 投稿内容／text型／NOTNULL
      t.text :sentence, null: false
      ## 添付画像ID／string型
      t.integer :image_id
      ## 編集済みフラグ／boolean型／NOTNULL／default:false
      t.boolean :is_edited, null: false, default: false
      ## 非表示フラグ／boolean型／NOTNULL／default:false
      t.boolean :is_hidden, null: false, default: false

      t.timestamps
    end
  end
end
