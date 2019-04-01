class Temporary < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ZENKAKU_MOJI      = /\A[ぁ-んァ-ン一-龥]/
  ZENKAKU_KANA      = /\A([ァ-ン]|ー)+\z/
  PHONE_NUMBER      = /\A\d{10}$|^\d{11}\z/
  POST_NUMBER       = /\A\d{3}[-]\d{4}\z|^\d{3}[-]\d{2}\z|^\d{3}\z|^\d{5}\z|^\d{7}\z/

  validates :nickname,        presence: true, length: { in: 1..20 }, uniqueness: true,on: :new_user
  validates :email,           presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false },on: :new_user

  validates :password,        presence: true, length: { in: 6..128 }, confirmation: true,on: :new_user


  validates :first_name,      presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_MOJI }, on: :profile_form

  validates :last_name,       presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_MOJI }, on: :profile_form

  validates :first_name_kana, presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_KANA }, on: :profile_form

  validates :last_name_kana,  presence: true, length: { in: 1..35 }, format: { with: ZENKAKU_KANA }, on: :profile_form

  validates :birth_year,      presence: true, on: :profile_form
  validates :birth_month,     presence: true, on: :profile_form
  validates :birth_day,       presence: true, on: :profile_form

  validates :post_number,     presence: true, format: { with: POST_NUMBER }, on: :address_form
  validates :prefecture_id,   presence: true, on: :address_form
  validates :city,            presence: true, on: :address_form
  validates :town,            presence: true, on: :address_form
  validates :phone_number,    presence: true, uniqueness: true, format: { with: PHONE_NUMBER }, on: :address_form

end
