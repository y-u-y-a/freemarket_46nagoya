class ChangeDatatypePhoneNumberOfTemporaries < ActiveRecord::Migration[5.0]
  def change
    change_column :temporaries, :phone_number, :string
  end
end
