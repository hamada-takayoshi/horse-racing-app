# RacePrize（レース賞金）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RacePrize` |
| 論理テーブル名 | レース賞金 |
| 概要 | 着順・賞金種別ごとの賞金額を保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RacePrizeId | レース賞金ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceId | レースID | BIGINT | NOT NULL |  | Race |  |
| 3 | PrizeTypeCode | 賞金種別コード | VARCHAR(20) | NOT NULL |  |  |  |
| 4 | FinishPosition | 着順 | TINYINT | NOT NULL |  |  |  |
| 5 | PrizeAmount | 賞金額 | BIGINT | NOT NULL |  |  |  |
| 6 | DataSourceId | 採用値取得元ID | INT | NOT NULL |  | DataSource |  |
| 7 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RacePrize PRIMARY KEY (RacePrizeId)
```

### 一意制約

```sql
CONSTRAINT UQ_RacePrize UNIQUE (RaceId, PrizeTypeCode, FinishPosition)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- 初期のPrizeTypeCodeはMAIN（本賞金）を想定。
