class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      # カラムを追加
      ## メンバーID／integer型／NOTNULL
      t.integer :member_id, null: false
      ## 投稿ID／integer型／NOTNULL
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
