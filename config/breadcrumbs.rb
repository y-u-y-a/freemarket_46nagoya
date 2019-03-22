crumb :root do
  link 'メルカリ', root_path
end

crumb :users do
  link 'マイページ', users_path
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
