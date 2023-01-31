class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # カラムを追加
      ## フォローしたユーザのID／integer型／NOTNULL
      t.integer :follower_id, null: false
      ## フォローされたユーザのID／integer型／NOTNULL
      t.integer :followed_id, null: false

      t.timestamps
    end
  end
end
