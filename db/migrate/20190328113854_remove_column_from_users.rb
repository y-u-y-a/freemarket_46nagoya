class RemoveColumnFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :uid,:integer
    remove_column :users, :provider,:integer
  end
end
