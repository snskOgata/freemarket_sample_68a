# README

* Ruby version

2.5.1

* System dependencies

Bundle 2.1.2

Rails 5.2.4.1

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# フリマアプリ DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false|
|password|string|null:false|
### Association
- has_many : sales
- has_many : orders
- has_many : cards
- has_one : profile
- has_one : address

## profiles テーブル
|Column|Type|Options|
|------|----|-------|
|lastname|string|null:false|
|firstname|string|null:false|
|lastname_kana|string|null:false|
|firstname_kana|string|null:false|
|birthday|date|null:false|
|user|references|foreign_key: true|
### Association
- belongs_to : user

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|phone_number|string||
|building|string||
|user|references|foreign_key: true|
### Association
- belongs_to :user

## cards テーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null:false|
|card_id|string|null:false|
|user|references|foreign_key: true|
### Association
- belongs_to : user

## salesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|condition_id|integer|null: false|
|delivery_payer|integer|null: false|
|prefecture|integer|null: false|
|prep_days|integer|null: false|
|price|integer|null: false|
|status|integer|null: false, default:true|
|seller|references|foreign_key: {to_column: :users}|
### Association
- has_many :images
- has_many :category_sales
- has_many :categories, through: category_sales
- belongs_to :seller, class_name "user"
- has_one :order

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|buyer|references|forein_key: {to_table: :users}|
|sale|references|forein_key: true|
### Association
- belongs_to :buyer, class_name "user"
- belongs_to :sale

## photosテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
|sale|references|foreign_key: true|
### Association
- belongs_to :sale

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|
### Association
- has_many :category_sales
- has_many :sale, through: category_sales
- has_ancestry

## category_salesテーブル
|Column|Type|Options|
|------|----|-------|
|category|references|forein_key: true|
|sale|references|forein_key: true|
### Association
- belongs_to :category
- belongs_to :sale

[![Image from Gyazo](https://i.gyazo.com/39585d967f064a979b61fd003db67ec4.png)](https://gyazo.com/39585d967f064a979b61fd003db67ec4)