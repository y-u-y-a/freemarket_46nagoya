class CreateTemporaries < ActiveRecord::Migration[5.0]
  def change
    create_table :temporaries do |t|
      t.string      :nickname
      t.string      :email
      t.string      :password
      t.string      :password_confirmation
      t.string      :first_name
      t.string      :last_name
      t.string      :first_name_kana
      t.string      :last_name_kana
      t.integer     :birth_year
      t.integer     :birth_month
      t.integer     :birth_day
      t.integer     :prefecture_id
      t.integer     :post_number
      t.string      :city
      t.string      :town
      t.string      :building
      t.integer     :phone_number

      t.timestamps
    end
  end
end
