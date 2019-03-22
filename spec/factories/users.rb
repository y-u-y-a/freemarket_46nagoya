FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.name}
    avatar                {Faker::Avatar.image}
    profile_text          {"fffff"}
    email                 {"aaa@aaa"}
    password              {"12345678"}
    password_confirmation {"12345678"}
    customer_id           {"cus_1db5dcaf0579a5f3e1e379cada3f"}
  end
end
