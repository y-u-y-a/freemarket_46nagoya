class AddColumnToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :shipping_way, :integer,default: 0
  end
end
