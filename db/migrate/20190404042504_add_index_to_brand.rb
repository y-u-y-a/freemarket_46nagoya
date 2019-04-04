class AddIndexToBrand < ActiveRecord::Migration[5.0]
  def change
    change_column :brands, :initial, :string
    add_index :brands, :initial
  end
end
