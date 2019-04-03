class AddPricedefaultToItems < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :price, :integer, default: 0
  end
end
