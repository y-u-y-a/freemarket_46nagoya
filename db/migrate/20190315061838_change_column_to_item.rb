class ChangeColumnToItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :shipping_date, :integer
  end
end
