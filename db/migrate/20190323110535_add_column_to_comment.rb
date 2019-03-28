class AddColumnToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :delete, :integer
  end
end
