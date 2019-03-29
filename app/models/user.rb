class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  has_many :items
  has_one :address
  has_one :profile
  has_many :comments ,dependent: :delete_all

  validates :nickname, presence: true
  validates :password, length: { minimum: 6 }   # 6文字以上で有効

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        nickname:     auth.info.name,
        email:    auth.info.email,
        token:    auth.credentials.token,
        password: Devise.friendly_token[0, 20]
        )
    end
    user
  end

  # private

  # def self.dummy_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end
end
