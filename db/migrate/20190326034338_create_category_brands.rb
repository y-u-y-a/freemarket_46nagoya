class CreateCategoryBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :category_brands do |t|
      t.references  :category,  foreign_key: true
      t.references  :brand,      foreign_key: true
      t.timestamps
    end
  end
end
