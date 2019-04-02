class AddColumnUsers < ActiveRecord::Migration[5.0]
  def change
    add_column    :users, :good, :integer, default: 0
    add_column    :users, :normal, :integer, default: 0
    add_column    :users, :bad, :integer, default: 0
  end
end
