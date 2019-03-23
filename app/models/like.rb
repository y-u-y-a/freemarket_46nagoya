class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item, counter_cache: :likes_count
end
