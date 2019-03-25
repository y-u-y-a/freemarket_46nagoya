class ChangeColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :profile_text, :text
    add_column :users, :profile_text, :text
  end
end
