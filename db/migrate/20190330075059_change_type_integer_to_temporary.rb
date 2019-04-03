class ChangeTypeIntegerToTemporary < ActiveRecord::Migration[5.0]
  def up
    change_column :temporaries, :phone_number, :bigint
  end

  def down
    change_column :temporaries, :phone_number, :integer
  end
end
