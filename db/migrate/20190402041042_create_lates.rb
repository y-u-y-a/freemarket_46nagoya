class CreateLates < ActiveRecord::Migration[5.0]
  def change
    create_table :lates do |t|
      t.integer :user_id
      t.integer :item_id
      t.text :text

      t.timestamps
    end
  end
end
