class ChangeColumnToItem2 < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :way_of_delivery, :integer
  end
end
