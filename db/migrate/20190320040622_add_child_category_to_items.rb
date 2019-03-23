class AddChildCategoryToItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :child_category, index: true
    add_reference :items, :grand_child_category, index: true
  end
end
