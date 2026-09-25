# RaceEntryMetric（出走馬指数）テーブル定義

## 1. テーブル概要

| 項目 | 内容 |
| --- | --- |
| 物理テーブル名 | `RaceEntryMetric` |
| 論理テーブル名 | 出走馬指数 |
| 概要 | 数値型の独自指標を提供元別・時点別に保持する。 |

## 2. カラム定義

| No. | 物理名 | 論理名 | データ型 | NULL | PK | FK | 説明 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | RaceEntryMetricId | 出走馬指数ID | BIGINT | NOT NULL | ○ |  |  |
| 2 | RaceEntryId | レース出走馬ID | BIGINT | NOT NULL |  | RaceEntry |  |
| 3 | MetricTypeCode | 指数種別コード | VARCHAR(30) | NOT NULL |  | MetricType |  |
| 4 | MetricValue | 指数値 | DECIMAL(18,6) | NOT NULL |  |  |  |
| 5 | UnitCode | 単位コード | VARCHAR(30) | NULL |  | Unit |  |
| 6 | DataSourceId | 提供元ID | INT | NOT NULL |  | DataSource |  |
| 7 | CalculatedAt | 算出日時 | DATETIME2 | NOT NULL |  |  |  |
| 8 | CreatedAt | 登録日時 | DATETIME2 | NOT NULL |  |  |  |
| 9 | UpdatedAt | 更新日時 | DATETIME2 | NOT NULL |  |  |  |

## 3. キー・制約

### 主キー

```sql
CONSTRAINT PK_RaceEntryMetric PRIMARY KEY (RaceEntryMetricId)
```

### 一意制約

```sql
CONSTRAINT UQ_RaceEntryMetric UNIQUE (RaceEntryId, MetricTypeCode, DataSourceId, CalculatedAt)
```

## 4. インデックス候補

必要に応じて実装時に追加する。

## 5. 設計上の補足

- スピード指数・予想勝率・期待値・馬場指数等を想定。
