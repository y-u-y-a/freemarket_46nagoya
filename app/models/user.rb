class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # usersテーブル
  validates :nickname, presence: true
  validates :password, length: { minimum: 6 }   # 6文字以上で有効


  # profilesテーブル
  has_one :profile
  accepts_nested_attributes_for :profile

  # before_create :build_default_profile
  # private
  # def build_default_profile
  #      build_profile
  #      true
  # end
end
