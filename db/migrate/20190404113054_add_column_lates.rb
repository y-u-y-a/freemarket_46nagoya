class AddColumnLates < ActiveRecord::Migration[5.0]
  def up
    add_column :lates, :late_user, :integer
  end
end
