FactoryBot.define do
  factory :item do
    name {"apple"}
    price {1000}
    explain {"aaa"}
    state{1}
    postage {1}
    shipping_date {1}
    shipping_way {1}
    user_id {1}
    user
  end
end
