class ItemImage < ApplicationRecord
  belongs_to :item, optional: true
  accepts_nested_attributes_for :item

  belongs_to :item, optional: true

  # mount_uploader :image, ImageUploader
end
