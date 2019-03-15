class ItemImage < ApplicationRecord
  belongs_to :item, optional: true
end
