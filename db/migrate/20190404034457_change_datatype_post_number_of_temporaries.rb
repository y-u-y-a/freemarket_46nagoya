class ChangeDatatypePostNumberOfTemporaries < ActiveRecord::Migration[5.0]
  def change
    change_column :temporaries, :post_number, :string
  end
end
