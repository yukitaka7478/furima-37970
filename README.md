# README

## usersテーブル

| Column              | Type     | Options            |
| ------------------- | -------- | -------------------|
| nickname            | string   | null: false        |
| email               | string   | null: false unique |
| encrypted_password  | string   | null: false        |
| last_name           | string   | null: false        |
| first_name          | string   | null: false        |
| last_name_kana      | string   | null: false        |
| first_name_kana     | string   | null: false        |
| birth_date          | date     | null: false        |

### Association
- has_many :items
- has_many :buys


## itemsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| explanation     | text       | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| postage_id      | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| sending_date_id | integer    | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buy


## buysテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliveriesテーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| municipality  | string     | null: false                    |
| house_num     | string     | null: false                    |
| building_name | string     |                                |
| telephone_num | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association
- belongs_to :buy








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
