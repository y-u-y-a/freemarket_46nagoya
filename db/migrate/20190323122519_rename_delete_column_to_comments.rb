class RenameDeleteColumnToComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :delete, :no_comment
  end
end
