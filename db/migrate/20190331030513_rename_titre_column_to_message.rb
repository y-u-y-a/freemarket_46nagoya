class RenameTitreColumnToMessage < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :buyer_id, :item_id
  end
end
