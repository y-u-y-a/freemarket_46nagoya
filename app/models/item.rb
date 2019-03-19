class Item < ApplicationRecord
<<<<<<< HEAD
  has_many :item_images
  accepts_nested_attributes_for :item_images
=======
  has_many :item_images,dependent: :delete_all
  accepts_nested_attributes_for :item_images
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :price, presence: true
  validates :state, presence: true
  validates :shipping_date, presence: true
  validates :postage, presence: true
  validates :shipping_way,presence: true

  enum state: {
    '新品、未使用': 1,
    '未使用に近い': 2,
    '目立った傷や汚れなし': 3,
    'やや傷や汚れなし': 4,
    '傷や汚れあり': 5,
    '全体的に状態が悪い': 6
  }

  enum shipping_date: {
    "1~2日で発送": 1,
    "2~3日で発送": 2,
    "4~7日で発送": 3
  }

  enum postage: {
    "送料込み(出品者負担)": 1,
    "着払い(購入者負担)": 2
  }

  enum shipping_way: {
    "未定": 1,
    "クロネコヤマト": 2,
    "ゆうパック": 3,
    "ゆうメール": 4
  }

>>>>>>> tsurutadesu/master
end
