FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.name}
    avatar                {Faker::Avatar.image}
    profile_text          {"fffff"}
    email                 {"aaa@aaa"}
    password              {"12345678"}
    password_confirmation {"12345678"}
  end
end
