class CreateMessagesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text        :text
      t.integer     :user_id
      t.integer     :item_id
      t.timestamps
    end
  end
end
