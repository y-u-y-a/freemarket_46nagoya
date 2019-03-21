class AddDepthToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :depth, :integer
  end
end
