class AddCategoryToItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :category_id, :integer
  end
end
