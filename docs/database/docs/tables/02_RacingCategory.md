# RacingCategory（競馬区分）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RacingCategory` |
| 論理テーブル名 | 競馬区分 |
| 概要 | 中央競馬・地方競馬などの大分類を管理する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RacingCategoryCode | 競馬区分コード | VARCHAR(20) | NOT NULL | ○ |  |  |
| 2 | RacingCategoryName | 競馬区分名 | NVARCHAR(50) | NOT NULL |  |  |  |
| 3 | SortOrder | 表示順 | SMALLINT | NOT NULL |  |  |  |
| 4 | IsActive | 有効フラグ | BIT | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RacingCategory PRIMARY KEY (RacingCategoryCode)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 初期値は CENTRAL（中央）、LOCAL（地方）。
