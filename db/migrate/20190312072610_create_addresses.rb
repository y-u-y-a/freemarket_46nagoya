class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references       :user,       foreign_key: true
      t.integer          :prefecture_id
      t.integer          :post_number
      t.string           :city
      t.string           :town
      t.string           :building

      t.timestamps
    end
  end
end
