class ChangeColumnToItem3 < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :buyer_id, :integer
    add_column :items, :business_stats, :integer
  end
end
