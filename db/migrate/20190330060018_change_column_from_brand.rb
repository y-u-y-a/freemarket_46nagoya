class ChangeColumnFromBrand < ActiveRecord::Migration[5.0]
  def change
    remove_column :brands, :name, :string
  end
end
