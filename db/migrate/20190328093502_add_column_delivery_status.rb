class AddColumnDeliveryStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :delivery_status, :integer, default: 0
  end
end
