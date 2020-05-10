<img width="1430" alt="スクリーンショット 2020-05-04 15 50 20" src="https://user-images.githubusercontent.com/57986669/80942150-06f3e900-8e1f-11ea-89bd-3841dfb59309.png">

# フリマクローンサイト
http://18.178.238.209

# Basic認証
user : admin <br>
pass : team65c <br><br>

■ テスト用アカウント<br>
◯ 購入者用<br>
メールアドレス：buyer@hoge.com<br>
パスワード：buyer1234<br><br>

◯ 購入用カード情報<br>
番号：4242424242424242<br>
期限：12/22<br>
セキュリティカード：123<br>

◯ 出品者用<br>
メールアドレス：seller@hoge.com<br>
パスワード：seller1234<br>
※確認後ログアウトお願いいたします。<br><br>


# DB設計

## usersテーブル 
|Column|Type|options|
|------|----|-------|
|first_name|string|null: false|  # first_name: 姓
|last_name|string|null: false|   # last_name: 名
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|birth_date|date|null:false|
|phone_number|string|null: false, unique: true|
### Associatioin
- has_many :items
- has_many :item_comments, dependent: :destroy
- has_one :users_addresses
- has_one :credit_cards
- has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"



## users_addressテーブル
|Column|Type|Options|
|------|----|-------|
|address_first_name|string|null: false|
|address_last_name|string|null: false|
|address_first_name_kana|string|null: false|
|address_last_name_kana|string|null: false|
|post_number|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|address_phone_number|string||
|user_id|references|null: false,foreign_key: true|
### Associatioin
- belongs_to :user



## credit_cardsテーブル 
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|card_id|string|null: false|
|customer_id|string|null: false|
### Association
- belongs_to :user



## itemsテーブル (商品)
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false| #description:商品説明
|status|integer|null: false| #status:商品状態
|postage|integer|null: false|  #postage:配送料の負担
|delivery_way|integer|null: false| #delivery_way:配送方法
|delivery_area|integer|null: false| #delivery_area:発送元地域
|delivery_day|integer|null :false| #delivery_day:発送までの目安
|price|integer|null: false|
|category|integer|null: false,foreign_key: true|
|size|integer||
|buyer_id|integer||
### Associatioin
- belongs_to :user
- has_many :item_comments, dependent: :destroy
- has_many :images
- belongs_to :category
- belongs_to :brand
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- accepts_nested_attributes_for :images, allow_destroy: true


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|item|references|null: false,foreign_key: true|
### Associatioin
- belongs_to :item




