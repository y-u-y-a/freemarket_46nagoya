class AddLikescountToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :likes_count, :integer
  end
end
