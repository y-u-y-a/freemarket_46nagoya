class AddColmunlate < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :late_count, :integer, default: 0
  end
end
