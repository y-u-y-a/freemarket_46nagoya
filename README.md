# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false,index: true|
|price|integer|null: false,index: true| <!-- 値段 -->
|explain|text|null: false|              <!-- 説明文 -->
|postage|integer|null: false|           <!-- 発送料 -->
|region|string|null: false|             <!-- 発送地 -->
|state|string|null: false|              <!--  商品状態 -->
|shipping_date|date|null: false|        <!-- 発送までの日数 -->
|size|integer||
|brand_id|integer||
|category_id|integer|null: false|

### Association
- has_many   comments    ,dependent: :delete_all
- belongs_to category
- belongs_to user
- belongs_to brand
- has_many   messages
- has_many   item_images ,dependent: :destroy_all


## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer|null: false|


### Association
- belongs_to item


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false,index: true|   <!-- ニックネーム -->
|avatar|string||                            <!-- ユーザー画像 -->
|profile_text|text||                        <!-- 自己紹介文 -->

### Association
- has_many  items,    dependent: :destroy
- has_many  comments  dependent: :destroy
- has_many  lates     dependent: :destroy
- has_many  messages  dependent: :destroy
- has_many  orders
- has_one   address   dependent: :destroy
- has_one   profiels  dependent: :delete
- has_one   socialprofiles dependent: :delete


## profielsテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|             <!-- 名前 -->
|last_name|string|null: false|              <!-- 苗字 -->
|first_name_kana|string|null: false|        <!-- 名前（カナ） -->
|last_name_kana|string|null: false|         <!-- 苗字（カナ） -->
|phone_number|integer|null: false,unique: true|          <!-- 電話番号 -->
|year_birth_at|date|null: false|            <!-- 誕生日（年） -->
|month_birth_at|date|null: false|           <!-- 誕生日（月） -->
|day_birth_at|date|null: false|             <!-- 誕生日（日） -->
|user_id|integer|null: false|

### Association
- belongs_to user


## ordersテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false|
|user_id|integer|null: false|
|buyer_id|integer||
|businnes_stats|integer|null: false|

### Association
- belongs_to  user
- belongs_to  item


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|item_id|integer|null: false|
|text|text|null: false|

### Association
- belongs_to  user
- belongs_to  item


## latesテーブル    <!-- 評価テーブル -->

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|text|text||
|evalution|integer||              <!-- 評価 -->
|item_id|integer|null: false|

### Association
- belongs_to  user


## brandsテーブル   <!-- ブランドテーブル -->

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many  items
- has_many  category through :bland-categorie


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer|null: false|

### Association
- belongs_to :parent, class_name: :Category
- has_many   :children, class_name: :Category, foreign_key: :parent_id
- has_many   blands through :bland-categorie


## bland-categorieテーブル

|Column|Type|Options|
|------|----|-------|
|bland_id|references|forgin_key: true,index: true|
|category_id|references|forgin_key: true,index: true|

### Association
- belongs_to  bland
- belongs_to  category


## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|buyer_id|integer|null: false|
|text|text|null: false|

### Association
- belongs_to  user
- belongs_to  item



## prefecturesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|                 <!--  都道府県 -->

### Association
- has_many  address


## addressテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|post_number|integer|null: false,index: false|    <!-- 住所 -->
|city|string|null: false|                         <!-- 市区町村 -->
|town|string|null: false|                         <!-- 番地 -->
|building|string||                                <!-- 建物名 -->
|prefecture_id|integenull: false|

### Association
- belongs_to  user
- belongs_to  prefectures


## socialprofilesテーブル

|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|facebook_name|string|null: false,index: false|
|google_name|string|null: false,index: false|
|facebook_email|string|null: false|
|google_email|string|null: false|
|user_id|integer|null: false|


### Association
- has_many  items
- has_many  comments
- has_many  lates
- has_many  messages
- has_many  address
- has_many  orders
