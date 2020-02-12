# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

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

* ...

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
- has_many : credits
- has_one : profile
- has_one : user_address

## profiles テーブル
|Column|Type|Options|
|------|----|-------|
|lastname|string|null:false|
|firstname|string|null:false|
|lastname_kana|string|null:false|
|firstname_kana|string|null:false|
|birthday|date|null:false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to : user

## user_addressテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|phone_number|string||
|building|string||
### Association
- belongs_to :users

## credits テーブル
|Column|Type|Options|
|------|----|-------|
|number|string|null:false|
|expiration_date|date|null:false|
|name|string|null:false|
|security|string|null:false|
### Association
- belongs_to : user

## salesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|delivery_payer|integer|null: false|
|from|integer|null: false|
|prep_days|integer|null: false|
### Association
- has_many :images
- has_many :categories, source: category
- belongs_to :user
- belongs_to :order

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|forein_key: true|
|sale|references|forein_key: true|
### Association
- has_many :images
- has_many :categories, source: category
- belongs_to :user
- belongs_to :sale

## photosテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|
### Association
- belongs_to :sale

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|
### Association
- has_many :sale
- has_ancestry

[![Image from Gyazo](https://i.gyazo.com/b60a0610125ab27a2d373eaf56045932.png)](https://gyazo.com/b60a0610125ab27a2d373eaf56045932)
