class ItemImage < ApplicationRecord
<<<<<<< HEAD
  belongs_to :item, optional: true
  accepts_nested_attributes_for :item

  # mount_uploader :image, ImageUploader
=======
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true
>>>>>>> tsurutadesu/master
end
