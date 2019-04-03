class AddSnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string,unique: true
    add_column :users, :uid, :string,unique: true
    add_column :users, :token, :string
  end
end
