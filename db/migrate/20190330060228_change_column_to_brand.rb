class ChangeColumnToBrand < ActiveRecord::Migration[5.0]
  def change
    add_column    :brands, :name, :string
  end
end
