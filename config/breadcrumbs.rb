crumb :root do
  link 'メルカリ', root_path
end

crumb :users do
  link 'マイページ', users_path(current_user)
  parent :root
end

crumb :all_categories_show do
  link 'カテゴリー一覧', all_categories_show_items_path
  parent :root
end

crumb :all_brands_show do
  link 'ブランド一覧', all_brands_show_items_path
  parent :root
end

crumb :logout do
  link 'ログアウト', logout_users_path
  parent :users
end

crumb :user do
  link 'プロフィール', user_path(current_user)
  parent :users
end

crumb :exhibition do
  link '出品した商品-出品中', exhibition_users_path(current_user)
  parent :users
end

crumb :seller_trading do
  link '出品した商品-取引中', seller_trading_users_path(current_user)
  parent :users
end

crumb :sold_page do
  link '出品した商品-売却済み', sold_page_users_path(current_user)
  parent :users
end

crumb :trading do
  link '購入した商品-取引中', trading_users_path(current_user)
  parent :users
end

crumb :purchased do
  link '購入した商品-過去の取引', purchased_users_path(current_user)
  parent :users
end

crumb :indentification do
  link "本人情報の登録", indentification_users_path
  parent :users
end

crumb :payment_method do
  link "支払い方法", payment_method_users_path
  parent :users
end

crumb :card_registration do
  link "クレジットカード情報入力", card_registration_users_path
  parent :payment_method
end

crumb :item_show do |item|
  link item.name, item_path
  parent :root
end
