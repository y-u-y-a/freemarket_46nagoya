class CreateItemImages < ActiveRecord::Migration[5.0]
  def change
    create_table :item_images do |t|
      t.string      :image
      t.integer     :item_id
      t.timestamps
    end
  end
end
