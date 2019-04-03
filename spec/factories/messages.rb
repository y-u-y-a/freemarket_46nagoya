FactoryBot.define do
  factory :message do
    text { "MyText" }
    user_id { 1 }
    buyer_id { 1 }
  end
end
