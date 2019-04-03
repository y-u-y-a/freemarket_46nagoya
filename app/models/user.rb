class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable

  mount_uploader :avatar, ImageUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :card_month
  belongs_to_active_hash :card_year
  belongs_to_active_hash :birth_year_select


  has_many :items
  has_one :address
  has_one :profile
  has_many :comments ,dependent: :delete_all


  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :following

  has_many :followers, through: :passive_relationships, source: :follower


  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nickname,        presence: true, length: { in: 1..20 }, uniqueness: true
  validates :email,           presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password,        presence: true, length: { in: 6..128 }, confirmation: true, on: :create

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        nickname:     auth.info.name,
        email:    auth.info.email,
        token:    auth.credentials.token,
        password: Devise.friendly_token[0, 20],
      )

      address = Address.new(
        user_id:        user.id,
      )
      address.save!(validate: false)
      Profile.create(
        user_id:         user.id,
      )
    end
    # user
  end

  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
