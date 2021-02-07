class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes
  validates :nickname, :prefecture_id, :introduction, presence: true
  validates :prefecture_id, numericality: {other_than: 0}
end
