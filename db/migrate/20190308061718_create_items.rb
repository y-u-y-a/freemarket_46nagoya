class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string      :name,   index: true
      t.integer     :price,  index: true
      t.text        :explain
      t.integer     :postage
      t.string      :region
      t.string      :state
      t.date        :shipping_date
      t.integer     :size
      t.integer     :brand_id
      t.integer     :category_id
      t.timestamps
    end
  end
end
