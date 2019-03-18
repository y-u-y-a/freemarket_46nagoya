class Item < ApplicationRecord
  has_many :item_images
  accepts_nested_attributes_for :item_images
end
