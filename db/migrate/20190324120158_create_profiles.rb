class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string      :first_name
      t.string      :last_name
      t.string      :first_name_kana
      t.string      :last_name_kana
      t.integer     :birth_year
      t.integer     :birth_month
      t.integer     :birth_day
      t.integer     :phone_number
      t.text        :profile_text
      t.references  :user,       foreign_key: true
      t.timestamps
    end
  end
end
