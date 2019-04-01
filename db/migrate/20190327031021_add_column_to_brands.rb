class AddColumnToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :initial, :text
  end
end
