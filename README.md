# ProtoSpaceのテーブル設計

## usersテーブル

| カラム名    | 型名    | NULL  | 備考 |
| ---------- | ------ | ----- | --- |
| email      | string | FALSE |     |
| password   | string | FALSE |     |
| name       | string | FALSE |     |
| profile    | text   | FALSE |     |
| occupation | text   | FALSE |     |
| position   | text   | FALSE |     |

### Association
- has_many :prototypes
- has_many :comments

## prototypesテーブル

| カラム名    | 型名        | NULL  | 備考 |
| ---------- | ---------- | ----- | --- |
| title      | string     | FALSE |     |
| catch_copy | text       | FALSE |     |
| concept    | text       | FALSE |     |
| user       | references |       |     |

### Association
- belongs_to :user
- has_many :comments

### commentsテーブル

| カラム名    | 型名         | NULL  | 備考 |
| ---------- | ----------- | ----- | --- |
| text       | text        | FALSE |     |
| user       | references  |       |     |
| prototype  | references  |       |     |

### Association
- belongs_to :user
- belongs_to :prototypes