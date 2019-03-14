class Profile < ApplicationRecord

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :birth_year,      presence: true
  validates :birth_month,     presence: true
  validates :birth_day,       presence: true
  validates :phone_number,    presence: true, uniquness: true
  validates :user_id,         presence: true
end
