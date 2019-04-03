class RemoveSizeFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :size, :integer
    remove_column :categories, :brand, :integer
    add_column :categories, :intro, :text
  end
end
