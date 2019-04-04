class ChangeDatatypePostNumberOfAddresses < ActiveRecord::Migration[5.0]
  def change
    change_column :addresses, :post_number, :string
  end
end
