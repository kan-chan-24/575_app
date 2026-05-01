class User < ApplicationRecord
  has_secure_password
  has_many :posts

  # パスワードのバリデーション  
  validates :password, length: { minimum: 8, maximum: 12 }, on: :create
  validates :password, length: { minimum: 8, maximum: 12 }, allow_blank: true, on: :update
  
  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 10 }
  
  # その他のバリデーション（必要に応じて追加）
  validates :email, presence: true, uniqueness: true
end
