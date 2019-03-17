class Item < ApplicationRecord
  has_many :item_images
  has_one  :order
  accepts_nested_attributes_for :item_images
  accepts_nested_attributes_for :order
end
