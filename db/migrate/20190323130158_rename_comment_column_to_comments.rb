class RenameCommentColumnToComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :comment, :text
  end
end
