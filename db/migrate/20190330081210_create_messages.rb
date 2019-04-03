class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.integer :user_id, null: false
      t.integer :buyer_id, null: false

      t.timestamps
    end
  end
end
