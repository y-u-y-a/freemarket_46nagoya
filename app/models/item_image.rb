class ItemImage < ApplicationRecord
  belongs_to :item, optional: true
  accepts_nested_attributes_for :item
  # mount_uploader :image, ImageUploader
end
