class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer     :item_id
      t.integer     :user_id
      t.integer     :buyer_id
      t.integer     :businnes_stats
      t.timestamps
    end
  end
end
