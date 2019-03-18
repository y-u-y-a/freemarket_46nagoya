FactoryBot.define do

  factory :items do
    name                  {Faker::Name.name}
    price                 {"1000"}
    explain               {"きれいです"}
    postage               {""}
    region                {"名古屋市"}
    state                 {""}
    shipping_date         {""}
    size                  {""}
    brand_id              {Faker::Number.number(1)}                             # 1ケタの数字でランダム生成
    category_id           {Faker::Number.number(1)}
    created_at            {Faker::Time.between(99.days.ago, Time.now, :all)}     # 100日間でランダム生成
  end

end
