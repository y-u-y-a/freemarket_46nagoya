FactoryBot.define do

  factory :item do
    name                  {Faker::Name.name}
    price                 {"1000"}
    explain               {"きれいです"}
    postage               {"1"}
    region                {"名古屋市"}
    state                 {"1"}
    shipping_date         {"1"}
    size                  {"1"}
    brand_id              {"1"}                                                 # 1ケタの数字でランダム生成
    category_id           {"1"}
    created_at            {Faker::Time.between(99.days.ago, Time.now, :all)}     # 100日間の間ででランダム生成
  end
end
# :itemを複数形の:itemsにすると、NameError：uninitialized const Itemというエラーが出る
