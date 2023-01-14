# frozen_string_literal: true

class DeviseCreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # カラムを追加
      ## 姓／string型／NOTNULL
      t.string :first_name, null: false
      ## 名／string型／NOTNULL
      t.string :last_name, null: false
      ## セイ／string型／NOTNULL
      t.string :first_name_kana, null: false
      ## メイ／string型／NOTNULL
      t.string :last_name_kana, null: false
      ## ニックネーム／string型／NOTNULL
      t.string :nickname, null: false
      ## 自己紹介文／text型
      t.text :introduction
      ## 退会フラグ／boolean型／NOTNULL／default:false
      t.boolean :is_deleted, null: false, default: false

      t.timestamps null: false
    end

    # 一意制約
    add_index :members, :email,                unique: true
    add_index :members, :reset_password_token, unique: true
    add_index :members, :nickname,             unique: true
    # add_index :members, :confirmation_token,   unique: true
    # add_index :members, :unlock_token,         unique: true
  end
end
