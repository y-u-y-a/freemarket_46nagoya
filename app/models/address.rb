class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  before_save   :remove_hyphen
  before_update :remove_hyphen

  PHONE_NUMBER      = /\A\d{10}$|^\d{11}\z/
  POST_NUMBER       = /\A\d{3}[-]\d{4}\z|^\d{3}[-]\d{2}\z|^\d{3}\z|^\d{5}\z|^\d{7}\z/


  validates :post_number,     presence: true, format: { with: POST_NUMBER }
  validates :city,            presence: true
  validates :town,            presence: true
  validates :phone_number,    presence: true, uniqueness: true, format: { with: PHONE_NUMBER }

  def remove_hyphen
    self.post_number = post_number.to_s.gsub(/[-]/,"")
  end
end
