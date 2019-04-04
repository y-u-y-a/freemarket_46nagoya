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
  link 'ブランド一覧', brand_path(1)
  parent :root
end

crumb :item_search_result do
  link "#{params[:q]["name_cont"]}",  item_search_result_items_path
  parent :root
end

crumb :logout do
  link 'ログアウト', logout_users_path
  parent :users
end

crumb :address_edit do
  link "発送元・お届け先住所変更", edit_user_address_path(current_user,current_user&.address)
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

crumb :lates do
  link '評価一覧', user_lates_path(current_user)
  parent :users
end

crumb :likes do
  link 'いいね! 一覧', user_likes_path(current_user)
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

crumb :trading_message_buy do
  link '取引画面', trading_message_item_path
  parent :trading
end

crumb :trading_message_sell do
  link '取引画面', trading_message_item_path
  parent :seller_trading
end

crumb :card_registration do
  link "クレジットカード情報入力", card_registration_users_path
  parent :payment_method
end

crumb :notification do
  link "お知らせ", notification_users_path
  parent :users
end

crumb :todo do
  link "やることリスト", todo_users_path
  parent :users
end

crumb :item_show do |item|
  link item.name, item_path
  parent :root
end

crumb :individual do |user|
  link user.nickname, individual_user_path(user)
  parent :root
end

crumb :following do
  link "フォロー"
  parent :root
end

crumb :followers do
  link "フォロワー"
  parent :root
end



# categories#show
# メンズ、レディース等の大カテゴリ
crumb :category_show do
  link "#{Category.find_by(id: params[:id]).name}",category_path
  parent :all_categories_show
end

# トップス、パンツ等の中カテゴリ
crumb :child_category_show do
  main_category_id = Category.find_by(id: params[:id]).main_category_id
  link "#{Category.find_by(id: main_category_id).name}",category_path(id: main_category_id)
  parent :all_categories_show
end
crumb :child_category_show_name do
  link "#{Category.find_by(id: params[:id]).name}"
  parent :child_category_show
end

# ポロシャツ、スラックス等の小カテゴリ
crumb :grand_child_category_show do
  sub_category_id = Category.find_by(id: params[:id]).sub_category_id
  link "#{Category.find_by(id: sub_category_id).name}",category_path(id: sub_category_id)
  parent :child_category_show
end
crumb :grand_child_category_name do
  link "#{Category.find_by(id: params[:id]).name}"
  parent :grand_child_category_show
end
