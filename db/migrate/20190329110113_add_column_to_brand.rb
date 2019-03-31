class AddColumnToBrand < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :intro, :text
  end
end
