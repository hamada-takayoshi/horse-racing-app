# RacePayout（払戻情報）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RacePayout` |
| 論理テーブル名 | 払戻情報 |
| 概要 | 確定払戻を券種・組合せ単位で保持する。選択対象種別はBetTypeから決定する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RacePayoutId | 払戻ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceId | レースID | BIGINT | NOT NULL |  | Race |  |
| 3 | BetTypeCode | 馬券種別コード | VARCHAR(30) | NOT NULL |  | BetType | BetType.SelectionTypeCodeから選択対象種別を判断 |
| 4 | SelectionKey | 正規化組合せキー | VARCHAR(50) | NOT NULL |  |  |  |
| 5 | PayoutAmount | 払戻金額 | INT | NOT NULL |  |  |  |
| 6 | Popularity | 人気順位 | TINYINT | NULL |  |  |  |
| 7 | DataSourceId | 採用値取得元ID | INT | NOT NULL |  | DataSource |  |
| 8 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 9 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RacePayout PRIMARY KEY (RacePayoutId)
```

### 一意制約

```sql
CONSTRAINT UQ_RacePayout
UNIQUE (RaceId, BetTypeCode, SelectionKey)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 選択対象種別は `BetType.SelectionTypeCode` を参照し、RacePayoutには重複保持しない。
- DataSourceIdは複数値並存用ではなく、採用した公式確定値の取得元を記録する。
