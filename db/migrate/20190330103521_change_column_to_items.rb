class ChangeColumnToItems < ActiveRecord::Migration[5.0]
  def up
    change_column :items, :likes_count, :integer, default: 0
  end

  def down
    change_column :items, :likes_count, :integer
  end
end
