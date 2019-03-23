class AddColumnToItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :user_id, :integer

    add_column :items, :user_id, :integer
  end
end
