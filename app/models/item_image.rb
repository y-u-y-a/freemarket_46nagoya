class ItemImage < ApplicationRecord

  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true
  accepts_nested_attributes_for :item

end
