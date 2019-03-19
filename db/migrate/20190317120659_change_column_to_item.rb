class ChangeColumnToItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :state, :integer, default: 0
    change_column :items, :postage, :integer, default: 0
    change_column :items, :shipping_date, :integer, default: 0
  end
end
