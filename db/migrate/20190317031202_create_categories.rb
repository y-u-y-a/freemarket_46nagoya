class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|

      t.references          :main_category,     null: true,    index: true
      t.references          :sub_category,      null: true,    index: true
      t.integer             :size
      t.integer             :brand
      t.string              :name,              null: false

      t.timestamps
    end
  end
end
