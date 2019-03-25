class AddColumnToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :phone_number, :integer
  end
end
