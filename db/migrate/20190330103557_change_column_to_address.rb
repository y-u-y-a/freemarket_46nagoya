class ChangeColumnToAddress < ActiveRecord::Migration[5.0]
  def up
    change_column :addresses, :phone_number, :bigint
  end

  def down
    change_column :addresses, :phone_number, :integer
  end
end
